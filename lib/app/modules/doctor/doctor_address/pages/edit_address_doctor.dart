import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/widget/edit_google_map_address_container.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/widget/edit_office_type.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressDoctor extends GetView<EditDoctorAddressController> {
  EditAddressDoctor({super.key});
  final officeAddress = Get.arguments[0] as OfficeAddreesModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDoctorAddressController>(
      initState: (_) {
        controller.setAddressData(officeAddress);
      },
      builder: (_) {
        return Scaffold(
          key: homeScaffoldKey,
          body: Stack(
            children: [
              Column(
                children: [
                  EditGoogleMapContainerAddress(
                    officeAddreesModel: officeAddress,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              15.verticalSpace,
                              Container(
                                height: 4,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  color: const Color(0xffC4C4C4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              14.verticalSpace,
                              Container(
                                height: 0.5,
                                // width: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        AppColors.blackBGColor.withOpacity(.25),
                                    width: .5,
                                  ),
                                ),
                              ),
                              20.verticalSpace,
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                // color: Colors.red,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: officeTypeList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          controller.slectedOffice.value =
                                              index;
                                        },
                                        child: EditOfficeType(
                                          index: index,
                                          officeTypeModel:
                                              officeTypeList[index],
                                        ));
                                  },
                                ),
                              ),
                              SizedBox(height: 3 * SizeConfig.heightMultiplier),
                              CommonTextfeild(
                                scanIcons: false,
                                obscuretext: false,
                                hinttext: "Title..",
                                controller: controller.title,
                                keyboardType: TextInputType.emailAddress,
                                showicon: false,
                                validations: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Title";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CommonTextfeild(
                                scanIcons: false,
                                obscuretext: false,
                                hinttext:
                                    "Description (ex. Orzi street, No 12..) ",
                                controller: controller.description,
                                keyboardType: TextInputType.emailAddress,
                                showicon: false,
                                validations: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Desc";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CommonTextfeild(
                                scanIcons: false,
                                obscuretext: false,
                                hinttext: "Street Number",
                                controller: controller.streetNumber,
                                keyboardType: TextInputType.streetAddress,
                                showicon: false,
                                validations: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Street";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CommonTextfeild(
                                scanIcons: false,
                                obscuretext: false,
                                hinttext: "Town Name",
                                controller: controller.townName,
                                keyboardType: TextInputType.streetAddress,
                                showicon: false,
                                validations: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Town Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CommonTextfeild(
                                scanIcons: false,
                                obscuretext: false,
                                hinttext: "City Name",
                                controller: controller.cityName,
                                keyboardType: TextInputType.streetAddress,
                                showicon: false,
                                validations: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter City Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CommonTextfeild(
                                scanIcons: false,
                                obscuretext: false,
                                hinttext: "Country Name",
                                controller: controller.countryName,
                                keyboardType: TextInputType.streetAddress,
                                showicon: false,
                                validations: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Country Name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 2 * SizeConfig.heightMultiplier),
                              CommonButton(
                                  ontap: () {
                                    if (controller.title.text.isNotEmpty &&
                                        controller
                                            .streetNumber.text.isNotEmpty &&
                                        controller.townName.text.isNotEmpty &&
                                        controller.cityName.text.isNotEmpty &&
                                        controller
                                            .countryName.text.isNotEmpty &&
                                        controller
                                            .description.text.isNotEmpty &&
                                        controller.long.value != 0.0 &&
                                        controller.lat.value != 0.0) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      controller.updateOffice(
                                          context: context,
                                          office: officeAddress);
                                    } else {
                                      showToastMessage(
                                          message:
                                              "Please Fill all Fields like Address",
                                          context: context,
                                          color: const Color(0xffEC1C24),
                                          icon: Icons.close);
                                    }
                                  },
                                  name: "Save"),
                              SizedBox(height: 1 * SizeConfig.heightMultiplier),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Obx(() {
                if (controller.processing) {
                  return const LoadingOverlay();
                }
                return const SizedBox();
              }),
            ],
          ),
        );
      },
    );
  }
}
