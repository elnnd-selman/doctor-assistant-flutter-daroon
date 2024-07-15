import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/auth_text_field.dart';

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
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            Text(
              "This feature allows you, as a doctor, to efficiently add assistants to your profile, streamlining your workflow and improving collaboration. Follow the simple steps below to add a new assistant.",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackBGColor.withOpacity(.5),
                fontSize: 1.2 * SizeConfig.heightMultiplier,
              ),
            ),
            SizedBox(height: 4 * SizeConfig.heightMultiplier),
            Text(
              "Assistant Information",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.lighttextColor,
                fontSize: 1.7 * SizeConfig.heightMultiplier,
              ),
            ),
            20.verticalSpace,
            CommonTextfeild(
              scanIcons: false,
              obscuretext: false,
              hinttext: "First name",
              controller: controller.userName,
              keyboardType: TextInputType.emailAddress,
              showicon: false,
              validations: (value) {
                if (value!.isEmpty) {
                  return "Enter User name";
                }
                return null;
              },
            ),
            16.verticalSpace,
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF7F7F8),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: Text(
                'Select Your Gender',
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xffA0A1AB),
                ),
              ),
              items: controller.genderList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColors.blackBGColor,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return '   Please select gender';
                }
                return null;
              },
              onChanged: (value) {
                controller.selectedGender.value = value.toString();
              },
              onSaved: (value) {
                controller.selectedGender.value = value.toString();
              },
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(right: 4 * SizeConfig.widthMultiplier),
              ),
              iconStyleData: IconStyleData(
                icon: SvgPicture.asset("assets/icons/downIcon.svg"),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            16.verticalSpace,
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF7F7F8),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: Text(
                'Select permission',
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xffA0A1AB),
                ),
              ),
              items: controller.premissionList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColors.blackBGColor,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return '   Please select permission';
                }
                return null;
              },
              onChanged: (value) {
                controller.selectedPremission.value = value.toString();
              },
              onSaved: (value) {
                controller.selectedPremission.value = value.toString();
              },
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(right: 4 * SizeConfig.widthMultiplier),
              ),
              iconStyleData: IconStyleData(
                icon: SvgPicture.asset("assets/icons/downIcon.svg"),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            16.verticalSpace,
            GestureDetector(
              onTap: () => Get.toNamed(Routes.doctorAssistantEditAddress,
                  arguments: {"isEditing": false}),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffF7F7F8),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  children: [
                    Text(
                      "Select Address",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: const Color(0xffA0A1AB),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryColor,
                      size: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
