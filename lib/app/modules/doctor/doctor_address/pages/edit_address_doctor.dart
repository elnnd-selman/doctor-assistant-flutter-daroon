import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/edit_doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/office_type_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/widget/edit_google_map_address_container.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/widget/edit_office_type.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                              Obx(
                                () => DropdownButtonFormField2<Country>(
                                  isExpanded: true,
                                  value: controller.currentCountryModel.value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffF7F7F8),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 22),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  hint: Text(
                                    'Select Country',
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color(0xff535353),
                                    ),
                                  ),
                                  items: controller.countryModelList
                                      .map<DropdownMenuItem<Country>>(
                                          (Country level) {
                                    return DropdownMenuItem<Country>(
                                      value: level,
                                      child: Text(
                                        level.countryEn!,
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: AppColors.blackBGColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return '   Please Choose Country';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.countryID.value = value!.id!;
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    padding: EdgeInsets.only(
                                        right: 4 * SizeConfig.widthMultiplier),
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: SvgPicture.asset(
                                        "assets/icons/downIcon.svg"),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    elevation: 0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF7F7F8),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
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
                                  const SizedBox(width: 20),
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
                                ],
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

                              const SizedBox(height: 20), ///////////
                              ////////////////
                              /// const SizedBox(height: 20),
                              Obx(
                                () => DropdownButtonFormField2<TypeOfCurrency>(
                                  isExpanded: true,
                                  value: controller.currentCurrencyModel.value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffF7F7F8),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 22),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  hint: Text(
                                    'Select Currency',
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color(0xff535353),
                                    ),
                                  ),
                                  items: controller.currencyModelList
                                      .map<DropdownMenuItem<TypeOfCurrency>>(
                                          (TypeOfCurrency level) {
                                    return DropdownMenuItem<TypeOfCurrency>(
                                      value: level,
                                      child: Text(
                                        level.typeOfCurrencyEn!,
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: AppColors.blackBGColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return '   Please Choose Currency';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.currencyID.value = value!.id!;
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    padding: EdgeInsets.only(
                                        right: 4 * SizeConfig.widthMultiplier),
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: SvgPicture.asset(
                                        "assets/icons/downIcon.svg"),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    elevation: 0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF7F7F8),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => DropdownButtonFormField2<TypeOfOffice>(
                                  isExpanded: true,
                                  value:
                                      controller.currentOfficeTypeModel.value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffF7F7F8),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 22),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  hint: Text(
                                    'Select Office Type',
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color(0xff535353),
                                    ),
                                  ),
                                  items: controller.officeModelList
                                      .map<DropdownMenuItem<TypeOfOffice>>(
                                          (TypeOfOffice level) {
                                    return DropdownMenuItem<TypeOfOffice>(
                                      value: level,
                                      child: Text(
                                        level.typeOfOfficeEn!,
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: AppColors.blackBGColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return '   Please Choose Currency';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.officeTypeID.value = value!.id!;
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    padding: EdgeInsets.only(
                                        right: 4 * SizeConfig.widthMultiplier),
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: SvgPicture.asset(
                                        "assets/icons/downIcon.svg"),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    elevation: 0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF7F7F8),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              SizedBox(height: 2 * SizeConfig.heightMultiplier),
                              CommonButton(
                                  ontap: () {
                                    controller.checkValition(
                                        context, officeAddress, true);
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
