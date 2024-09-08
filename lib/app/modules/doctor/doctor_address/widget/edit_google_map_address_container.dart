import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/google_map_key.dart';

class EditGoogleMapContainerAddress extends StatefulWidget {
  final OfficeAddreesModel officeAddreesModel;
  const EditGoogleMapContainerAddress({
    super.key,
    required this.officeAddreesModel,
  });

  @override
  State<EditGoogleMapContainerAddress> createState() =>
      _EditGoogleMapContainerAddressState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _EditGoogleMapContainerAddressState
    extends State<EditGoogleMapContainerAddress> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  final Mode _mode = Mode.overlay;
  final ctrl = Get.find<EditDoctorAddressController>();

  @override
  void initState() {
    super.initState();

    // changeMarkerIcon();
    setData();
  }

  setData() async {
    markersList.clear();
    markersList.add(Marker(
        icon: markerIcon,
        markerId: const MarkerId("1"),
        position: LatLng(
            widget.officeAddreesModel.address!.coordinate!.latitude!,
            widget.officeAddreesModel.address!.coordinate!.longitude!),
        infoWindow: const InfoWindow(title: "")));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.only(
      //     top: MediaQuery.of(Get.context!).size.height * 0.06, left: 10, right: 10),
      height: MediaQuery.of(Get.context!).size.height * 0.5,
      width: MediaQuery.of(Get.context!).size.width,

      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(Get.context!).size.height * 0.5,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markersList,
              mapType: MapType.terrain,
              onTap: (location) {
                final lat = location.latitude;
                final lng = location.longitude;
                ctrl.lat.value = location.latitude;
                ctrl.long.value = location.longitude;

                markersList.clear();
                markersList.add(Marker(
                    icon: markerIcon,
                    markerId: const MarkerId("1"),
                    position: LatLng(lat, lng),
                    infoWindow: const InfoWindow(title: "")));

                googleMapController.animateCamera(
                    CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16.5));
                setState(() {});
              },
              onMapCreated: (GoogleMapController controller) async {
                googleMapController = controller;
                await googleMapController.animateCamera(
                    CameraUpdate.newLatLngZoom(
                        LatLng(
                            widget.officeAddreesModel.address!.coordinate!
                                .latitude!,
                            widget.officeAddreesModel.address!.coordinate!
                                .longitude!),
                        16.5));
                setState(() {});
              },
            ),
          ),

          Positioned(
            top: MediaQuery.of(Get.context!).size.height * 0.08,
            left: 20,
            right: 20,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    "assets/icons/Arrow Left-Outline.svg",
                    height: MediaQuery.of(Get.context!).size.height * 0.025,
                  ),
                ),
                Text(
                  "Edit Address",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1C1B1F),
                    fontSize: SizeConfig.heightMultiplier * 1.8,
                  ),
                ),
                InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _handlePressButton();
                    },
                    child: SvgPicture.asset(Assets.serachIcon)),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: MediaQuery.of(Get.context!).size.height * 0.024),
          //   child: Obx(
          //     () => SearchBarAnimation(
          //       isOriginalAnimation: false,
          //       buttonColour: ctrl.isAppBarOpen.value
          //           ? const Color(0xffF7F7F8)
          //           : AppColors.whiteBGColor,
          //       searchBoxColour: const Color(0xffF7F7F8).withOpacity(1),
          //       isSearchBoxOnRightSide: true,
          //       enableBoxShadow: false,
          //       enableButtonShadow: false,
          //       hintText: "Search Address",
          //       buttonBorderColour: Colors.black45,
          //       searchBoxWidth: MediaQuery.of(Get.context!).size.width * 0.94,
          //       onFieldSubmitted: (String value) {
          //         debugPrint('onFieldSubmitted value $value');
          //       },
          //       onPressButton: (open) {
          //         ctrl.isAppBarOpen.value = open;
          //       },
          //       textEditingController: TextEditingController(),
          //       trailingWidget: SvgPicture.asset(
          //         Assets.serachIcon,
          //         colorFilter: const ColorFilter.mode(
          //             Color(0xff979797), BlendMode.srcIn),
          //       ),
          //       secondaryButtonWidget: const Icon(Icons.close),
          //       buttonWidget: SvgPicture.asset(Assets.serachIcon),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  changeMarkerIcon() {
    BitmapDescriptor.asset(
            const ImageConfiguration(), "assets/icons_png/Vector.png")
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: kGoogleMapKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      strictbounds: false,
      types: [""],
      // decoration: InputDecoration(
      //     hintText: 'Search',
      //     focusedBorder: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(20),
      //         borderSide: BorderSide(color: Colors.white))),
      // components: [
      //   Component(Component.country, "pk"),
      //   Component(Component.country, "usa")
      // ],
    );

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
    // ScaffoldMessenger.of(Get.context!).showSnackBar(
    //   SnackBar(
    //     elevation: 0,
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.transparent,
    //     content: Get.snackbar(
    //       'Message',
    //       response.errorMessage!,
    //     ),
    //   ),
    // );

    // homeScaffoldKey.currentState!
    //     .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleMapKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    ctrl.lat.value = detail.result.geometry!.location.lat;
    ctrl.long.value = detail.result.geometry!.location.lng;

    setState(() {
      ctrl.description.text = detail.result.formattedAddress!;
    });

    markersList.clear();
    markersList.add(Marker(
        icon: markerIcon,
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16.5));
  }
}