import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/user_search_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserScreen extends GetView<AddAssistantController> {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (controller.selectedUserIndex.value == -1) {
            showToastMessage(
                message: "Please Select User",
                context: context,
                color: const Color(0xffEC1C24),
                icon: Icons.close);
          } else {
            Get.back();
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
            "Search Users",
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
            EdgeInsets.symmetric(horizontal: 4 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              CommonTextfeild(
                obscuretext: false,
                hinttext: "Search User",
                validations: null,
                controller: controller.searchUser,
                keyboardType: TextInputType.emailAddress,
                showicon: false,
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
                              top: MediaQuery.of(context).size.height * 0.33),
                          child: const CircularProgressIndicator(
                              color: AppColors.blackBGColor),
                        ),
                      )
                    : controller.userSearchModelList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15),
                            child: const NoDataWidget(
                                backGroundcolor: AppColors.secondaryborderColor,
                                svgIconColor: Colors.white,
                                iconType: true,
                                iconPath: "assets/icons_png/no_location.png",
                                title: "No User",
                                description: "No User Found"),
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
            ],
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final UserSearchDataModel user;
  final int index;
  final Color borderColor;
  final Function()? onTap;

  const UserTile(
      {super.key,
      required this.user,
      required this.index,
      required this.borderColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          decoration: BoxDecoration(
              // color: const Color(0xffF7F7F8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Get.find<AddAssistantController>()
                              .selectedUserIndex
                              .value ==
                          index
                      ? AppColors.primaryColor
                      : const Color(0xffE8E8E8),
                  width: .5)),
          child: Row(
            children: [
              Column(
                children: [
                  user.profilePicture == null
                      ? Container(
                          height: 5 * SizeConfig.heightMultiplier,
                          width: 5 * SizeConfig.heightMultiplier,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.blackBGColor,
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                '${user.firstName![0].toUpperCase()}${user.lastNameEn![0].toUpperCase()}',
                                style: AppTextStyles.bold.copyWith(
                                  color: Colors.white,
                                  fontSize: Spaces.fontSize(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 5 * SizeConfig.heightMultiplier,
                          width: 5 * SizeConfig.heightMultiplier,
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // color: AppColors.blackBGColor,
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: NetWorkImageLoader(
                                    containerColor: Colors.black54,
                                    imageURL: user.profilePicture!.md!,
                                    height: 5 * SizeConfig.heightMultiplier,
                                    width: 5 * SizeConfig.heightMultiplier),
                              ),
                            ),
                          ),
                        )
                ],
              ),
              SizedBox(width: 2 * SizeConfig.widthMultiplier),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName!.toUpperCase()} ${user.lastNameEn!.toUpperCase()}',
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackBGColor,
                      fontSize: 1.8 * SizeConfig.heightMultiplier,
                    ),
                  ),
                  Text(
                    user.gender!,
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.lighttextColor,
                      fontSize: 1.6 * SizeConfig.heightMultiplier,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 3 * SizeConfig.heightMultiplier,
                width: 3 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(
                    color: Get.find<AddAssistantController>()
                                .selectedUserIndex
                                .value ==
                            index
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor,
                    )),
                child: Icon(
                  Icons.check,
                  size: 2 * SizeConfig.heightMultiplier,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
    // ListTile(
    //   leading:
    //   title: Text(
    //     user.fullName!,
    //     style: AppTextStyles.medium.copyWith(
    //       fontWeight: FontWeight.w500,
    //       color: AppColors.blackBGColor,
    //       fontSize: 1.8 * SizeConfig.heightMultiplier,
    //     ),
    //   ),
    //   subtitle: Text(
    //     user.gender!,
    //     style: AppTextStyles.medium.copyWith(
    //       fontWeight: FontWeight.w400,
    //       color: AppColors.lighttextColor,
    //       fontSize: 1.6 * SizeConfig.heightMultiplier,
    //     ),
    //   ),
    // );
  }
}
