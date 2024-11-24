import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/search_user_screen.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class AddAssistantScreen extends GetView<AddAssistantController> {
  const AddAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Add Assistant",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomCupertinoButton(
        onTap: () {
          if (controller.selectedUserIndex.value == -1) {
            showToastMessage(
                message: "Please Select User",
                context: context,
                color: const Color(0xffEC1C24),
                icon: Icons.close);
          } else {
            // Get.back();
            Get.toNamed(Routes.doctorAssistantEditAddress,
                arguments: {"isEditing": false});
          }
        },
        child: Container(
          height: 5.5 * SizeConfig.heightMultiplier,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "Next",
              style: AppTextStyles.bold.copyWith(
                fontSize: 16,
                color: AppColors.whiteBGColor,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              Text(
                "This feature allows you, as a doctor, to efficiently add assistants to your profile, streamlining your workflow and improving collaboration. Follow the simple steps below to add a new assistant.",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackBGColor.withOpacity(.5),
                  fontSize: 1.5 * SizeConfig.heightMultiplier,
                ),
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),

              SearchTextfeild(
                obscuretext: false,
                hinttext: "Search User",
                validations: null,
                controller: controller.searchUser,
                borderColor: Colors.transparent,
                keyboardType: TextInputType.emailAddress,
                showicon: true,
                scanIcons: false,
                onChange: (val) {
                  if (val.isNotEmpty) {
                    controller.searchUserInApi(val);
                  } else {
                    controller.userSearchModelList.value = [];
                  }
                },
              ),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.20),
                          child: const CircularProgressIndicator(
                              color: AppColors.blackBGColor),
                        ),
                      )
                    : controller.userSearchModelList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.10),
                            child: const NoDataWidget(title: "No User Found"),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.reFetchLoader.value
                                ? controller.userSearchModelList.length + 1
                                : controller.userSearchModelList.length,
                            itemBuilder: (context, index) {
                              if (index <
                                  controller.userSearchModelList.length) {
                                return UserTile(
                                    onTap: () {
                                      controller.selectedUserIndex.value =
                                          index;
                                      controller.selectedUserID.value =
                                          controller
                                              .userSearchModelList[index].id!;
                                      controller.selectedUserName.value =
                                          controller.userSearchModelList[index]
                                              .firstName!;
                                    },
                                    borderColor:
                                        controller.selectedUserIndex.value ==
                                                index
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                    index: index,
                                    user:
                                        controller.userSearchModelList[index]);
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.blackBGColor),
                                );
                              }
                            }),
              ),
              // CustomCupertinoButton(
              //   onTap: () => Get.toNamed(
              //     Routes.searchUser,
              //   ),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 14, vertical: 16),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: const Color(0xffF7F7F8),
              //       border: Border.all(color: AppColors.borderColor),
              //     ),
              //     child: Row(
              //       children: [
              //         Obx(
              //           () => Text(
              //             controller.selectedUserIndex.value == -1
              //                 ? "Search User"
              //                 : controller.selectedUserName.value
              //                     .toUpperCase(),
              //             style: AppTextStyles.medium.copyWith(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 15,
              //               color: controller.selectedUserIndex.value == -1
              //                   ? const Color(0xffA0A1AB)
              //                   : AppColors.primaryColor,
              //             ),
              //           ),
              //         ),
              //         const Spacer(),
              //         const Icon(
              //           Icons.arrow_forward_ios_rounded,
              //           color: AppColors.primaryColor,
              //           size: 18,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // CommonTextfeild(
              //   scanIcons: false,
              //   obscuretext: false,
              //   hinttext: "First name",
              //   controller: controller.userName,
              //   keyboardType: TextInputType.emailAddress,
              //   showicon: false,
              //   validations: (value) {
              //     if (value!.isEmpty) {
              //       return "Enter User name";
              //     }
              //     return null;
              //   },
              // ),
              // 16.verticalSpace,
              // DropdownButtonFormField2<String>(
              //   isExpanded: true,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: const Color(0xffF7F7F8),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: AppColors.borderColor),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: AppColors.borderColor),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(vertical: 16),
              //     border: OutlineInputBorder(
              //       borderSide: const BorderSide(color: AppColors.borderColor),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              //   hint: Text(
              //     'Select Your Gender',
              //     style: AppTextStyles.medium.copyWith(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //       color: const Color(0xffA0A1AB),
              //     ),
              //   ),
              //   items: controller.genderList
              //       .map((item) => DropdownMenuItem<String>(
              //             value: item,
              //             child: Text(
              //               item,
              //               style: AppTextStyles.medium.copyWith(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 15,
              //                 color: AppColors.blackBGColor,
              //               ),
              //             ),
              //           ))
              //       .toList(),
              //   validator: (value) {
              //     if (value == null) {
              //       return '   Please select gender';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     controller.selectedGender.value = value.toString();
              //   },
              //   onSaved: (value) {
              //     controller.selectedGender.value = value.toString();
              //   },
              //   buttonStyleData: ButtonStyleData(
              //     padding: EdgeInsets.only(right: 4 * SizeConfig.widthMultiplier),
              //   ),
              //   iconStyleData: IconStyleData(
              //     icon: SvgPicture.asset("assets/icons/downIcon.svg"),
              //     iconSize: 24,
              //   ),
              //   dropdownStyleData: DropdownStyleData(
              //     elevation: 0,
              //     decoration: BoxDecoration(
              //       color: const Color(0xffF7F7F8),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              //   menuItemStyleData: const MenuItemStyleData(
              //     padding: EdgeInsets.symmetric(horizontal: 16),
              //   ),
              // ),
              // 16.verticalSpace,
              // MultiSelectDropDown(
              //   controller: controller.multiSelectController,
              //   clearIcon: const Icon(
              //     Icons.highlight_remove_rounded,
              //     color: AppColors.blackBGColor,
              //     size: 18,
              //   ),
              //   onOptionSelected: (options) {
              //     controller.selectedPremissionList.value = [];
              //     for (int i = 0;
              //         i <
              //             controller
              //                 .multiSelectController.selectedOptions.length;
              //         i++) {
              //       controller.selectedPremissionList.add(controller
              //           .multiSelectController.selectedOptions[i].label);
              //     }
              //   },

              //   hint: 'Select permission',
              //   dropdownBorderRadius: 15,
              //   optionsBackgroundColor: Colors.transparent,
              //   focusedBorderColor: Colors.transparent,
              //   suffixIcon: const Icon(
              //     Icons.keyboard_arrow_down_rounded,
              //     color: AppColors.primaryColor,
              //     size: 24,
              //   ),
              //   dropdownBackgroundColor: const Color(0xffF7F7F8),
              //   dropdownHeight: MediaQuery.of(context).size.height * 0.12,
              //   inputDecoration: BoxDecoration(
              //     color: const Color(0xffF7F7F8),
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: AppColors.borderColor),
              //   ),

              //   hintPadding: const EdgeInsets.symmetric(vertical: 16),
              //   hintStyle: AppTextStyles.medium.copyWith(
              //     fontWeight: FontWeight.w400,
              //     fontSize: 15,
              //     color: const Color(0xffA0A1AB),
              //   ),
              //   // fieldBackgroundColor: const Color(0xffF7F7F8),
              //   //  Text(
              //   //   'Select permission',
              //   //   style: AppTextStyles.medium.copyWith(
              //   //     fontWeight: FontWeight.w400,
              //   //     fontSize: 15,
              //   //     color: const Color(0xffA0A1AB),
              //   //   ),
              //   // ),
              //   options: const <ValueItem<String>>[
              //     ValueItem(label: 'Manage Appointments', value: ""),
              //     ValueItem(
              //       label: 'Manage Posts',
              //       value: "",
              //     ),
              //   ],
              //   maxItems: 2,
              //   singleSelectItemStyle: const TextStyle(
              //       fontSize: 16, fontWeight: FontWeight.bold),
              //   chipConfig: ChipConfig(
              //     wrapType: WrapType.wrap,
              //     labelStyle: AppTextStyles.medium.copyWith(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //       color: AppColors.whiteBGColor,
              //     ),
              //     // deleteIconColor: Colors.r,
              //     backgroundColor: AppColors.primaryColor,
              //   ),
              //   // optionTextStyle: const TextStyle(fontSize: 16, color: Colors.red),
              //   selectedOptionIcon: const Icon(
              //     Icons.check_circle,
              //     color: AppColors.primaryColor,
              //   ),
              //   selectedOptionBackgroundColor: Colors.transparent,
              //   selectedOptionTextColor: Colors.transparent,
              //   searchBackgroundColor: Colors.transparent,
              //   borderColor: Colors.transparent,
              //   dropdownMargin: 2,

              //   onOptionRemoved: (index, option) {
              //     controller.selectedPremissionList
              //         .removeWhere((val) => val == option.label);
              //     print(controller.selectedPremissionList.length);
              //   },
              //   optionBuilder: (context, valueItem, isSelected) {
              //     return ListTile(
              //       title: Text(
              //         valueItem.label,
              //         style: AppTextStyles.medium.copyWith(
              //           fontWeight: FontWeight.w400,
              //           fontSize: 15,
              //           color: AppColors.blackBGColor,
              //         ),
              //       ),
              //       trailing: isSelected
              //           ? const Icon(Icons.check_circle)
              //           : const Icon(Icons.radio_button_unchecked),
              //     );
              //   },
              // ),
              // DropdownButtonFormField2<String>(
              //   isExpanded: true,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: const Color(0xffF7F7F8),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: AppColors.borderColor),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: AppColors.borderColor),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(vertical: 16),
              //     border: OutlineInputBorder(
              //       borderSide: const BorderSide(color: AppColors.borderColor),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              //   hint: Text(
              //     'Select permission',
              //     style: AppTextStyles.medium.copyWith(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //       color: const Color(0xffA0A1AB),
              //     ),
              //   ),
              //   items: controller.premissionList
              //       .map((item) => DropdownMenuItem<String>(
              //             value: item,
              //             child: Text(
              //               item,
              //               // controller.selectedPremissionList.isEmpty
              //               //     ? item
              //               //     : controller.selectedPremissionList.length == 1
              //               //         ? controller.selectedPremissionList.string[0]
              //               //         : controller.selectedPremissionList.length ==
              //               //                 2
              //               //             ? "${controller.selectedPremissionList[0]},${controller.selectedPremissionList[1]}"
              //               //             : item,
              //               style: AppTextStyles.medium.copyWith(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 15,
              //                 color: AppColors.blackBGColor,
              //               ),
              //             ),
              //           ))
              //       .toList(),
              //   validator: (value) {
              //     if (value == null) {
              //       return '   Please select permission';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     controller.selectedPremission.value = value.toString();
              //     if (controller.selectedPremissionList.contains(value)) {
              //       controller.selectedPremissionList.remove(value);
              //     } else {
              //       controller.selectedPremissionList.add(value);
              //     }
              //   },
              //   onSaved: (value) {
              //     controller.selectedPremission.value = value.toString();
              //   },
              //   buttonStyleData: ButtonStyleData(
              //     padding: EdgeInsets.only(right: 4 * SizeConfig.widthMultiplier),
              //   ),
              //   iconStyleData: IconStyleData(
              //     icon: SvgPicture.asset("assets/icons/downIcon.svg"),
              //     iconSize: 24,
              //   ),
              //   dropdownStyleData: DropdownStyleData(
              //     elevation: 0,
              //     decoration: BoxDecoration(
              //       color: const Color(0xffF7F7F8),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              //   menuItemStyleData: const MenuItemStyleData(
              //     padding: EdgeInsets.symmetric(horizontal: 16),
              //   ),
              // ),
              // 16.verticalSpace,
              // CustomCupertinoButton(
              //   onTap: () => Get.toNamed(Routes.doctorAssistantEditAddress,
              //       arguments: {"isEditing": false}),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 14, vertical: 16),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: const Color(0xffF7F7F8),
              //       border: Border.all(color: AppColors.borderColor),
              //     ),
              //     child: Row(
              //       children: [
              //         Obx(
              //           () => Text(
              //             controller.selectedIndex.value == -1
              //                 ? "Select Address"
              //                 : controller.selectedAddress.value,
              //             style: AppTextStyles.medium.copyWith(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 15,
              //               color: controller.selectedIndex.value == -1
              //                   ? const Color(0xffA0A1AB)
              //                   : AppColors.primaryColor,
              //             ),
              //           ),
              //         ),
              //         const Spacer(),
              //         const Icon(
              //           Icons.arrow_forward_ios_rounded,
              //           color: AppColors.primaryColor,
              //           size: 18,
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              // const Spacer(),
              // CommonButton(
              //     ontap: () {
              //       if (controller.selectedIndex.value == -1 &&
              //           controller.selectedPremissionList.isEmpty &&
              //           controller.selectedUserIndex.value == -1) {
              //         showToastMessage(
              //             message: "Please Select Data",
              //             context: context,
              //             color: const Color(0xffEC1C24),
              //             icon: Icons.close);
              //       } else {
              //         controller.createAssistant(context);
              //       }
              //     },
              //     name: "Save"),
            ],
          ),
        ),
      ),
    );
  }
}
