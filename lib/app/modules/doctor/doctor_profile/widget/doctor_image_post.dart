import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_comment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/comment_bottom_sheet.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/video_player_post.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorImagePostContainer extends StatefulWidget {
  final ContentData contentData;
  final int index;
  const DoctorImagePostContainer(
      {super.key, required this.contentData, required this.index});

  @override
  State<DoctorImagePostContainer> createState() =>
      _DoctorImagePostContainerState();
}

class _DoctorImagePostContainerState extends State<DoctorImagePostContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryborderColor, width: 0.5),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Get.find<DoctorHomeController>()
                          .userModel
                          .value!
                          .user!
                          .profilePicture ==
                      null
                  ? Container(
                      height: 5 * SizeConfig.heightMultiplier,
                      width: 5 * SizeConfig.heightMultiplier,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: AppColors.blackBGColor,
                          shape: BoxShape.circle),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            '${Get.find<DoctorHomeController>().userModel.value!.user!.username![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.firstName![0].toUpperCase()}',
                            style: AppTextStyles.bold.copyWith(
                              color: Colors.white,
                              fontSize: Spaces.fontSize(fontSize: 18),
                            ),
                          ),
                        ),
                      ))
                  : CircleAvatar(
                      radius: 14,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: Get.find<DoctorHomeController>()
                              .userModel
                              .value!
                              .user!
                              .profilePicture,
                          fit: BoxFit.cover,
                          height: 5 * SizeConfig.heightMultiplier,
                          width: 5 * SizeConfig.heightMultiplier,
                        ),
                      ),
                    ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Get.find<DoctorHomeController>()
                        .userModel
                        .value!
                        .user!
                        .username!,
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackBGColor,
                      fontSize: SizeConfig.heightMultiplier * 1.6,
                    ),
                  ),
                  Text(
                    Get.find<DoctorProfileController>().convertDateToformat(
                        widget.contentData.updatedAt.toString()),
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff717171),
                      fontSize: SizeConfig.heightMultiplier * 1.6,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildMenu(context),
            ],
          ),
          SizedBox(height: 2.5 * SizeConfig.heightMultiplier),
          Text(
            widget.contentData.contentEn!,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xff484848),
              fontSize: SizeConfig.heightMultiplier * 1.6,
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          widget.contentData.imageVideoUrl.isEmpty
              ? const SizedBox()
              : CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    // aspectRatio: 2.0,
                    // initialPage: 2,
                  ),
                  itemCount: widget.contentData.imageVideoUrl.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    if (widget.contentData.imageVideoUrl[itemIndex].urlType ==
                        "imageUrl") {
                      return Container(
                        height: 25 * SizeConfig.heightMultiplier,
                        width: MediaQuery.of(context).size.width * .8,
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.028),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: widget
                                .contentData.imageVideoUrl[itemIndex].url!,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.blackBGColor.withOpacity(0.3),
                            colorBlendMode: BlendMode.darken,
                            placeholder: (context, url) {
                              return const LoadingWidget();
                            },
                            placeholderFadeInDuration: 0.75.seconds,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 25 * SizeConfig.heightMultiplier,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.028),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.transparent),
                        child: VideoPlayerPost(
                          videoPath:
                              widget.contentData.imageVideoUrl[itemIndex].url!,
                        ),
                      );
                    }
                  }),
          SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
          Container(
            height: .5,
            color: const Color(0xffE4E4E4),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Row(
            children: [
              Row(
                children: [
                  CupertinoButton(
                      pressedOpacity: 0,
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      onPressed: () => Get.find<DoctorProfileController>()
                          .updateLikeOnPost(
                              contentData: widget.contentData,
                              index: widget.index),
                      child: Icon(
                        widget.contentData.isLiked!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.contentData.isLiked!
                            ? AppColors.primaryColor
                            : Colors.black,
                      )),
                  const SizedBox(width: 4),
                  CupertinoButton(
                    pressedOpacity: 0,
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () => Get.toNamed(Routes.postLikeUserDetail),
                    child: Text(
                      " ${widget.contentData.likes} Likes",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff484848),
                        fontSize: SizeConfig.heightMultiplier * 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              20.horizontalSpace,
              _buildLikeRow(
                " 0 Comment",
                Assets.commentIcon,
                () {
                  Get.lazyPut(() =>
                      PostCommentController(postID: widget.contentData.id!));

                  Get.bottomSheet(
                    CommentBottomSheet(contentData: widget.contentData),
                    isScrollControlled: true,
                    isDismissible: true,
                    enableDrag: false,
                  );
                  // showModalBottomSheet(
                  //   context: Get.context!,
                  //   builder: (context) => const CommentBottomSheet(),
                  //   isScrollControlled: true,
                  //   isDismissible: true,
                  //   backgroundColor: Colors.transparent,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(24),
                  //   ),
                  // );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  CupertinoButton _buildLikeRow(
      String title, String iconUrl, Function()? onTap) {
    return CupertinoButton(
      pressedOpacity: 0,
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            iconUrl,
            height: 16,
          ),
          Text(
            title,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xff484848),
              fontSize: SizeConfig.heightMultiplier * 1.4,
            ),
          ),
        ],
      ),
    );
  }

  List<String> menuList = [
    "Edit",
    "Delete",
  ];
  CustomPopupMenuController customPopupMenuController =
      CustomPopupMenuController();

  _buildMenu(BuildContext context) {
    return CustomPopupMenu(
      arrowColor: Colors.white,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: menuList
                  .map(
                    (item) => CustomCupertinoButton(
                      onTap: () {
                        customPopupMenuController.hideMenu();

                        if (item == "Delete") {
                          Get.dialog(
                            CustomDialogBox(
                              title: 'Delete Post',
                              iconPath: Assets.deleteIcon,
                              onPressedConfirm: () {
                                Get.back();
                                Get.find<DoctorProfileController>().deletePost(
                                    index: widget.index,
                                    contentData: widget.contentData,
                                    context: context);
                              },
                              confirmButtonColor: const Color(0xffEC1C24),
                              subTitle:
                                  'Are you sure you want to\ndelete ${widget.contentData.titleEn} ?',
                            ),
                            barrierColor:
                                AppColors.blackBGColor.withOpacity(0.5),
                          );
                        } else {
                          Get.toNamed(Routes.postUpdate, arguments: [
                            widget.contentData,
                          ]);
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: item == "Edit"
                                            ? Colors.black
                                            : const Color(0xffEC1C24)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          item == "Edit"
                              ? Container(
                                  height: .5,
                                  color: const Color(0xffC4C4C4),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      position: PreferredPosition.bottom,
      controller: customPopupMenuController,
      child: Container(
        height: 7 * SizeConfig.heightMultiplier,
        width: 7 * SizeConfig.widthMultiplier,
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SvgPicture.asset(
            "assets/icons/circlurDot.svg",
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

enum Options { edit, delete }
