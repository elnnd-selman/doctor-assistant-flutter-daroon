import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/add_doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/widget/google_map_address_container.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';

class AddDoctorAddressScreen extends GetView<AddDoctorAddressController> {
  const AddDoctorAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Column(
        children: [
          const GoogleMapContainerAddress(),
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
                            color: AppColors.blackBGColor.withOpacity(.25),
                            width: .5,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        // color: Colors.red,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: officeTypeList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  controller.slectedOffice.value = index;
                                },
                                child: OfficeTypeContainer(
                                  index: index,
                                  officeTypeModel: officeTypeList[index],
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
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextfeild(
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CommonTextfeild(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextfeild(
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
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CommonTextfeild(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CommonTextfeild(
                        scanIcons: false,
                        obscuretext: false,
                        hinttext: "Description (ex. Orzi street, No 12..) ",
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
                      SizedBox(height: 2 * SizeConfig.heightMultiplier),
                      CommonButton(
                          ontap: () {
                            if (controller.title.text.isNotEmpty &&
                                controller.streetNumber.text.isNotEmpty &&
                                controller.townName.text.isNotEmpty &&
                                controller.cityName.text.isNotEmpty &&
                                controller.countryName.text.isNotEmpty &&
                                controller.description.text.isNotEmpty &&
                                controller.long.value != 0.0 &&
                                controller.lat.value != 0.0) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.toNamed(Routes.addDoctorAdressDetail);
                            } else {
                              showToastMessage(
                                  message:
                                      "Please Fill all Fields like Address",
                                  context: context,
                                  color: const Color(0xffEC1C24),
                                  icon: Icons.close);
                            }
                          },
                          name: "Next"),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OfficeTypeContainer extends StatelessWidget {
  final OfficeTypeModel officeTypeModel;
  final int index;
  const OfficeTypeContainer({
    super.key,
    required this.officeTypeModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddDoctorAddressController>();
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(
            // vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.06),
        decoration: BoxDecoration(
            color: const Color(0xff979797).withOpacity(.09),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: controller.slectedOffice.value == index
                    ? AppColors.primaryColor
                    : Colors.transparent)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              officeTypeModel.imageUrl,
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.002,
            ),
            Text(
              officeTypeModel.title,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackBGColor,
                fontSize: SizeConfig.heightMultiplier * 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
