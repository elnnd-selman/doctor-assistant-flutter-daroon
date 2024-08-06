import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
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
                            '${Get.find<DoctorHomeController>().userModel.value!.user!.username![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.name![0].toUpperCase()}',
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
              // Container(
              //   height: 5 * SizeConfig.heightMultiplier,
              //   width: 5 * SizeConfig.heightMultiplier,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage("assets/images/tempImages.png"),
              //       ),
              //       shape: BoxShape.circle),
              // ),
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
              SvgPicture.asset(
                "assets/icons/circlurDot.svg",
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
                height: 20,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(contentData.images.length, (index) {
                  return Container(
                    height: 25 * SizeConfig.heightMultiplier,
                    width: MediaQuery.of(context).size.width * .8,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.028),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: contentData.images[index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.blackBGColor.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                        placeholder: (context, url) {
                          return const BlurHash(
                            hash:
                                "https://rebazdevdata.s3-eu-central-1.amazonaws.com/daroon/images/cf2fe9157bdd40fbef32619c-scaled_1000117414.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQAVTYUR3S7EOIVH4%2F20240701%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20240701T095716Z&X-Amz-Expires=600&X-Amz-Signature=e1fa83bc43181b2ed291784d5d8d18f6fc098d3ca8a499b98903c2574b6dcad1&X-Amz-SignedHeaders=host",
                            imageFit: BoxFit.cover,
                          );
                        },
                        placeholderFadeInDuration: 0.75.seconds,
                      ),
                    ),
                  );
                }),
                ...List.generate(contentData.videos.length, (index) {
                  return Container(
                    height: 25 * SizeConfig.heightMultiplier,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.028),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.transparent),
                    child: VideoPlayerPost(
                      videoPath: contentData.videos[index],
                    ),
                  );
                })
              ],
            ),
          ),
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
                  showModalBottomSheet(
                    context: Get.context!,
                    builder: (context) => const CommentBottomSheet(),
                    isScrollControlled: true,
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  );
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
}

List<String> videoList = [
  "https://firebasestorage.googleapis.com/v0/b/the-fittest.appspot.com/o/Exercise-Videos%2Fbiceps%2FBand_Concentration_Curl_female.mp4?alt=media&token=d37813c7-a816-4852-a08c-6512ca8e5757",
  "https://firebasestorage.googleapis.com/v0/b/the-fittest.appspot.com/o/Exercise-Videos%2Fbiceps%2FBand_Concentration_Curl_female.mp4?alt=media&token=d37813c7-a816-4852-a08c-6512ca8e5757",
  "https://firebasestorage.googleapis.com/v0/b/the-fittest.appspot.com/o/Exercise-Videos%2Fbiceps%2FBand_Concentration_Curl_female.mp4?alt=media&token=d37813c7-a816-4852-a08c-6512ca8e5757",
];

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.2 +
            MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.only(
        //   top: MediaQuery.of(Get.context!).size.height * 0.08,
        // ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 1.2 * SizeConfig.heightMultiplier),
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffE7E8EA),
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(height: 1.2 * SizeConfig.heightMultiplier),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 6 * SizeConfig.heightMultiplier,
                        width: 6 * SizeConfig.heightMultiplier,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: .5 * SizeConfig.heightMultiplier),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "Melvin Joseph",
                                    style: AppTextStyles.medium.copyWith(
                                      color: const Color(0xff11142D),
                                      fontWeight: FontWeight.w600,
                                    )),
                                const TextSpan(
                                    text:
                                        " it's never too late to start something new. Start easy. Because needs a process. We can not imArticletely get the best results. At least, let's get started.",
                                    style: TextStyle(
                                      color: Color(0xff11142D),
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
              Container(
                height: .5,
                color: const Color(0xffE4E4E4),
              ),
              SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
              Container(
                height: 55 * SizeConfig.heightMultiplier,
                // color: Colors.red,
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.72,
                      child: TextFormField(
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColors.blackBGColor,
                        ),
                        cursorColor: Colors.black12,
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 14),
                          fillColor: const Color(0xffF7F7F8),
                          filled: true,
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE7E8EA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE7E8EA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE7E8EA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE7E8EA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE7E8EA)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          isDense: true,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              Assets.sendIcon,
                            ),
                          ),
                          hintText: "Send Comment",
                          hintStyle: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xff535353),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  //
                  Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xffE4E4E4).withOpacity(.3),
                      border: Border.all(
                        color: const Color(0xffE4E4E4),
                      ),
                    ),
                    child: Center(
                      child: Text("😍",
                          style: AppTextStyles.medium.copyWith(
                            color: const Color(0xff11142D),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 1 * SizeConfig.heightMultiplier),
            ],
          ),
        ),
      ),
    );
  }
}
