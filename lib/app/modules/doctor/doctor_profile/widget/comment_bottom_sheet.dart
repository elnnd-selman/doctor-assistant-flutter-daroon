import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_comment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/comment_setion.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommentBottomSheet extends GetView<PostCommentController> {
  const CommentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PostCommentController());
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
            // padding: EdgeInsets.zero,
            // shrinkWrap: true,
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
              const Expanded(child: CommentSection()),
              // const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01),
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.72,
                      child: TextFormField(
                        focusNode: controller.commentFieldFocusNode,
                        controller: controller.commentTextController,
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
                          suffixIcon: InkWell(
                            onTap: () {
                              if (controller.selectedCommentIndex.value == -1) {
                                controller.sendCommentOnPost();
                              } else {
                                // controller.sendReply();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                Assets.sendIcon,
                              ),
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
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
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
