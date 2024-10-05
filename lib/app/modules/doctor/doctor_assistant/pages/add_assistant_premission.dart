import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AddAssistantPremission extends GetView<AddAssistantController> {
  const AddAssistantPremission({super.key});

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
            "Select Permission",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (controller.selectedPremissionList.isEmpty) {
            showToastMessage(
                message: "Please Select Permission",
                context: context,
                color: const Color(0xffEC1C24),
                icon: Icons.close);
          } else {
            controller.createAssistant(context);
            // // Get.back();
            // Get.toNamed(Routes.doctorAssistantEditAddress,
            //     arguments: {"isEditing": false});
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
              "Save",
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4 * SizeConfig.heightMultiplier),
                Text(
                  "You can select how you want the assistant assist you. by managing your posts or appointment or both.",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackBGColor.withOpacity(.5),
                    fontSize: 1.5 * SizeConfig.heightMultiplier,
                  ),
                ),
                SizedBox(height: 4 * SizeConfig.heightMultiplier),
                MultiSelectDropDown(
                  controller: controller.multiSelectController,
                  clearIcon: const Icon(
                    Icons.highlight_remove_rounded,
                    color: AppColors.blackBGColor,
                    size: 18,
                  ),
                  onOptionSelected: (options) {
                    controller.selectedPremissionList.value = [];
                    for (int i = 0;
                        i <
                            controller
                                .multiSelectController.selectedOptions.length;
                        i++) {
                      controller.selectedPremissionList.add(controller
                          .multiSelectController.selectedOptions[i].label);
                    }
                  },

                  hint: 'Select permission',
                  dropdownBorderRadius: 15,
                  optionsBackgroundColor: Colors.transparent,
                  focusedBorderColor: Colors.transparent,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  dropdownBackgroundColor: const Color(0xffF7F7F8),
                  dropdownHeight: MediaQuery.of(context).size.height * 0.12,
                  inputDecoration: BoxDecoration(
                    color: const Color(0xffF7F7F8),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.borderColor),
                  ),

                  hintPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  hintStyle: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color(0xff535353),
                  ),
                  // fieldBackgroundColor: const Color(0xffF7F7F8),
                  //  Text(
                  //   'Select permission',
                  //   style: AppTextStyles.medium.copyWith(
                  //     fontWeight: FontWeight.w400,
                  //     fontSize: 15,
                  //     color: const Color(0xffA0A1AB),
                  //   ),
                  // ),
                  options: const <ValueItem<String>>[
                    ValueItem(label: 'Manage Appointments', value: ""),
                    ValueItem(
                      label: 'Manage Posts',
                      value: "",
                    ),
                  ],
                  maxItems: 2,
                  singleSelectItemStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  chipConfig: ChipConfig(
                    wrapType: WrapType.wrap,
                    labelStyle: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColors.whiteBGColor,
                    ),
                    // deleteIconColor: Colors.r,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  // optionTextStyle: const TextStyle(fontSize: 16, color: Colors.red),
                  selectedOptionIcon: const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                  ),
                  selectedOptionBackgroundColor: Colors.transparent,
                  selectedOptionTextColor: Colors.transparent,
                  searchBackgroundColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  dropdownMargin: 2,

                  onOptionRemoved: (index, option) {
                    controller.selectedPremissionList
                        .removeWhere((val) => val == option.label);
                  },
                  optionBuilder: (context, valueItem, isSelected) {
                    return ListTile(
                      title: Text(
                        valueItem.label,
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColors.blackBGColor,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.radio_button_unchecked),
                    );
                  },
                ),
              ],
            ),
            Obx(() {
              if (controller.processing) {
                return const LoadingWidget();
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
