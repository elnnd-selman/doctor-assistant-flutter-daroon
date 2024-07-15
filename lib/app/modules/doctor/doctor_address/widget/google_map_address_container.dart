import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hezr/app/modules/doctor/doctor_address/controller/add_doctor_address_controller.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/google_map_key.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class GoogleMapContainerAddress extends StatefulWidget {
  const GoogleMapContainerAddress({
    super.key,
  });

  @override
  State<GoogleMapContainerAddress> createState() =>
      _GoogleMapContainerAddressState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _GoogleMapContainerAddressState extends State<GoogleMapContainerAddress> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
  final ctrl = Get.find<AddDoctorAddressController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.only(
      //     top: MediaQuery.of(context).size.height * 0.06, left: 10, right: 10),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,

      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markersList,
              mapType: MapType.terrain,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
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
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
                Text(
                  "Add Address",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1C1B1F),
                    fontSize: SizeConfig.heightMultiplier * 1.8,
                  ),
                ),
                InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _handlePressButton(context);
                    },
                    child: SvgPicture.asset(Assets.serachIcon)),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: MediaQuery.of(context).size.height * 0.024),
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
          //       searchBoxWidth: MediaQuery.of(context).size.width * 0.94,
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

  Future<void> _handlePressButton(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
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
    // ScaffoldMessenger.of(context).showSnackBar(
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

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
