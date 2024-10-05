import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_comment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/comment_bottom_sheet.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
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

class DoctorImagePostContainer extends StatelessWidget {
  final ContentData contentData;
  const DoctorImagePostContainer({super.key, required this.contentData});

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
                    Get.find<DoctorProfileController>()
                        .convertDateToformat(contentData.updatedAt.toString()),
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff717171),
                      fontSize: SizeConfig.heightMultiplier * 1.6,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                // iconSize: 20,
                padding: EdgeInsets.zero,
                elevation: 0,

                // shadowColor: Colors.red,
                color: AppColors.whiteBGColor,
                child: SvgPicture.asset(
                  "assets/icons/circlurDot.svg",
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                  height: 20,
                ),
                onSelected: (value) {
                  _onMenuItemSelected(value as int);
                },
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem(
                      'Edit', true, Options.edit.index, AppColors.blackBGColor),
                  _buildPopupMenuItem('Delete', false, Options.delete.index,
                      const Color(0xffEC1C24)),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.5 * SizeConfig.heightMultiplier),
          Text(
            contentData.contentEn!,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xff484848),
              fontSize: SizeConfig.heightMultiplier * 1.6,
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                // aspectRatio: 2.0,
                // initialPage: 2,
              ),
              itemCount: contentData.imageVideoUrl.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                if (contentData.imageVideoUrl[itemIndex].urlType ==
                    "imageUrl") {
                  return Container(
                    height: 25 * SizeConfig.heightMultiplier,
                    width: MediaQuery.of(context).size.width * .8,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.028),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: contentData.imageVideoUrl[itemIndex].url!,
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
                      videoPath: contentData.imageVideoUrl[itemIndex].url!,
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
              _buildLikeRow(
                " ${contentData.likes} Likes",
                Assets.likeIcon,
                () {},
              ),
              20.horizontalSpace,
              _buildLikeRow(
                " 0 Comment",
                Assets.commentIcon,
                () {
                  Get.lazyPut(
                      () => PostCommentController(postID: contentData.id!));

                  Get.bottomSheet(
                    CommentBottomSheet(contentData: contentData),
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

  InkWell _buildLikeRow(String title, String iconUrl, Function()? onTap) {
    return InkWell(
      onTap: onTap,
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

  PopupMenuItem _buildPopupMenuItem(
      String title, bool showDivider, int position, Color textColor) {
    return PopupMenuItem(
      padding: EdgeInsets.zero,
      value: position,
      child: Column(
        children: [
          showDivider ? 0.verticalSpace : 10.verticalSpace,
          Center(
            child: Text(
              title,
              style:
                  AppTextStyles.normal.copyWith(fontSize: 16, color: textColor),
            ),
          ),
          15.verticalSpace,
          showDivider
              ? Container(height: .5, color: const Color(0xffC4C4C4))
              : const SizedBox(),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    // _popupMenuItemIndex = value;

    if (value == Options.edit.index) {
      // _changeColorAccordingToMenuItem = Colors.red;
    } else if (value == Options.delete.index) {}
  }
}

List<String> videoList = [
  "https://firebasestorage.googleapis.com/v0/b/the-fittest.appspot.com/o/Exercise-Videos%2Fbiceps%2FBand_Concentration_Curl_female.mp4?alt=media&token=d37813c7-a816-4852-a08c-6512ca8e5757",
  "https://firebasestorage.googleapis.com/v0/b/the-fittest.appspot.com/o/Exercise-Videos%2Fbiceps%2FBand_Concentration_Curl_female.mp4?alt=media&token=d37813c7-a816-4852-a08c-6512ca8e5757",
  "https://firebasestorage.googleapis.com/v0/b/the-fittest.appspot.com/o/Exercise-Videos%2Fbiceps%2FBand_Concentration_Curl_female.mp4?alt=media&token=d37813c7-a816-4852-a08c-6512ca8e5757",
];

enum Options { edit, delete }
