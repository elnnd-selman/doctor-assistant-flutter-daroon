import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_comment_controller.dart';
import 'package:daroon_doctor/app/modules/linkfy_text/src/enum.dart';
import 'package:daroon_doctor/app/modules/linkfy_text/src/linkify.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSection extends GetView<PostCommentController> {
  const CommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => controller.commentsLoading.value
            ? LoadingWidget()
            : controller.commetnModelList.value!.data.isEmpty
                ? Text("No Commetn")
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.commetnModelList.value!.data.length,
                    itemBuilder: (context, index) {
                      return _buildComment(commentIndex: index);
                    }),
      ),
    );

    // Container(

    //     // child: Stack(
    //     //   children: [
    //     //     Obx(
    //     //       () => Column(
    //     //         children: [
    //     //           if (controller.commentsLoading.isFalse)
    //     //             Expanded(
    //     //               child: FadeIn(
    //     //                 child: Padding(
    //     //                   padding: const EdgeInsets.symmetric(horizontal: 20),
    //     //                   child: SingleChildScrollView(
    //     //                     controller: controller.commentSectionScrollController,
    //     //                     child: Column(
    //     //                       crossAxisAlignment: CrossAxisAlignment.start,
    //     //                       mainAxisSize: MainAxisSize.min,
    //     //                       children: [
    //     //                         RichText(
    //     //                           text: TextSpan(
    //     //                             text: 'Comments',
    //     //                             style: AppTextStyles.semiBold.copyWith(
    //     //                               fontSize: 22.responsiveFontSize,
    //     //                               color: AppColors.blackBGColor,
    //     //                             ),
    //     //                             // children: [
    //     //                             //   TextSpan(
    //     //                             //     text:
    //     //                             //         ' (${controller.commentsList.length})',
    //     //                             //     style: AppTextStyles.semiBold.copyWith(
    //     //                             //       fontSize: 20,
    //     //                             //       color: AppColors.blackBGColor,
    //     //                             //     ),
    //     //                             //   ),
    //     //                             // ],
    //     //                           ),
    //     //                         ),
    //     //                         14.verticalSpace,
    //     //                         Obx(
    //     //                           () => (controller.commentsList.isNotEmpty)
    //     //                               ? Column(
    //     //                                   children: [
    //     //                                     for (var commentIndex = 0;
    //     //                                         commentIndex <
    //     //                                             controller
    //     //                                                 .commentsList.length;
    //     //                                         commentIndex++) ...[
    //     //                                       _buildComment(
    //     //                                         commentIndex: commentIndex,
    //     //                                       ),
    //     //                                       if (commentIndex <
    //     //                                           controller.commentsList.length -
    //     //                                               1)
    //     //                                         14.verticalSpace,
    //     //                                     ],
    //     //                                     150.verticalSpace,
    //     //                                     SizedBox(
    //     //                                       height: MediaQuery.of(Get.context!)
    //     //                                           .viewInsets
    //     //                                           .bottom,
    //     //                                     ),
    //     //                                   ],
    //     //                                 )
    //     //                               : _buildNoCommentsSection(),
    //     //                         ),
    //     //                       ],
    //     //                     ),
    //     //                   ),
    //     //                 ),
    //     //               ),
    //     //             )
    //     //           else
    //     //             const Expanded(
    //     //               child: Center(
    //     //                 child: CircularProgressIndicator(
    //     //                   strokeWidth: 1,
    //     //                   color: AppColors.blackBGColor,
    //     //                 ),
    //     //               ),
    //     //             ),
    //     //         ],
    //     //       ),
    //     //     ),
    //     //   ],
    //     // ),
    //     );
  }

  Widget _buildNoCommentsSection() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: const NoDataWidget(
        title: 'No Comments',
        description: 'When someone comments on this post you will see it here.',
        iconPath: 'assets/icons/svg/coment.svg',
        backGroundcolor: AppColors.whiteBGColor,
        svgIconColor: AppColors.blackBGColor,
        iconBgColor: Colors.white,
      ),
    );
  }

  Widget _buildComment({required int commentIndex}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteBGColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (controller
              //     .commetnModelList.value!.data[commentIndex].comment!.isNotEmpty)
              //   SizedBox(
              //     width: 50,
              //     height: 50,
              //     child: CircleAvatar(
              //       backgroundColor: AppColors.whiteBGColor,
              //       backgroundImage: CachedNetworkImageProvider(
              //         controller
              //             .commentsList[commentIndex].commentAuthorImageUrl,
              //       ),
              //     ),
              //   )
              // else
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColors.blackBGColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // child: Center(
                //   child: Text(
                //     '${controller.commentsList[commentIndex].commentAuthorFirstName.isNotEmpty == true ? controller.commentsList[commentIndex].commentAuthorFirstName[0] : "A"}${controller.commentsList[commentIndex].commentAuthorLastName.isNotEmpty == true ? controller.commentsList[commentIndex].commentAuthorLastName[0] : "Z"}',
                //     style: AppTextStyles.bold.copyWith(
                //         fontSize: 20.responsiveFontSize, color: Colors.white),
                //   ),
                // ),
              ),
              12.horizontalSpace,
              Expanded(
                child: SizedBox(
                  height: 47,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Comment User Name',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackBGColor,
                              ),
                            ),
                          ),
                          16.horizontalSpace
                        ],
                      ),
                      Text(
                        controller.getCommentTimeDifference(
                          commentIndex: commentIndex,
                        ),
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 12,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          17.verticalSpace,

          if (controller.commetnModelList.value!.data[commentIndex].comment!
              .isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: LinkifyText(
                controller.commetnModelList.value!.data[commentIndex].comment!,
                textStyle: AppTextStyles.normal.copyWith(
                  fontSize: 14,
                  color: AppColors.blackBGColor,
                ),
                linkTypes: const [LinkType.userTag, LinkType.hashTag],
                linkStyle: AppTextStyles.semiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            15.verticalSpace,
          ],
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        // controller.addLike(
                        //     commentIndex: commentIndex, isReplay: false);
                      },
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '${controller.commetnModelList.value!.data[commentIndex].likes != null ? controller.commetnModelList.value!.data[commentIndex].likes! : 0}   Likes',
                        style: AppTextStyles.semiBold.copyWith(
                          color: controller.commentLikedByMe(
                                  commentIndex: commentIndex)
                              ? AppColors.blackBGColor
                              : AppColors.greyColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    CupertinoButton(
                      onPressed: () {
                        // controller.setReplyMode(commentIndex: commentIndex);
                      },
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Reply',
                        style: AppTextStyles.semiBold.copyWith(
                          color: AppColors.greyColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    20.horizontalSpace,
                    // SizedBox(
                    //   width: MediaQuery.of(Get.context!).size.width * 0.6,
                    //   child: EmojiListWidget(
                    //     emojiList:
                    //         controller.commentsList[commentIndex].commentEmojiList,
                    //     onEmojiTap: (emoji) {
                    //       controller.addEmojiToComment(
                    //         emoji.emoji,
                    //         commentIndex,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                // CupertinoButton(
                //   onPressed: () {
                //     final uid = Get.find<AuthController>().user!.uid;
                //     final isVerified =
                //         Get.find<AppConfigurationController>().isAdminUser();
                //     if (isVerified ||
                //         controller.commentsList[commentIndex].commentAuthorID ==
                //             uid) {
                //       showModalBottomSheet(
                //         context: Get.context!,
                //         constraints: BoxConstraints(
                //             maxWidth: MediaQuery.of(Get.context!).size.width),
                //         builder: (context) => AuthorOptionsSheet(
                //           onEditPressed: () => controller.editComment(
                //             commentIndex: commentIndex,
                //           ),
                //           onDeletePressed: () => controller.deleteComment(
                //             comment: controller.commentsList[commentIndex],
                //           ),
                //         ),
                //         isScrollControlled: true,
                //         isDismissible: true,
                //         shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(24),
                //             topRight: Radius.circular(24),
                //           ),
                //         ),
                //       );
                //     } else {
                //       showModalBottomSheet(
                //         context: Get.context!,
                //         constraints: BoxConstraints(
                //             maxWidth: MediaQuery.of(Get.context!).size.width),
                //         builder: (context) => ReportSheet(
                //           reportingOn: 'Comment',
                //           username: controller
                //               .commentsList[commentIndex].commentAuthorUsername,
                //           onReport: (reason) => controller.reportComment(
                //             comment: controller.commentsList[commentIndex],
                //             reason: reason,
                //           ),
                //           onBlock: () async {
                //             final blocked =
                //                 await Get.find<CommunityController>().blockUser(
                //               controller
                //                   .commentsList[commentIndex].commentAuthorID,
                //               controller.commentsList[commentIndex]
                //                   .commentAuthorUsername,
                //             );

                //             if (blocked) {
                //               final uid = controller
                //                   .commentsList[commentIndex].commentAuthorID;
                //               controller.commentsList.removeWhere(
                //                 (e) => e.commentAuthorID == uid,
                //               );
                //             }
                //           },
                //         ),
                //         isScrollControlled: true,
                //         isDismissible: true,
                //         shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(24),
                //             topRight: Radius.circular(24),
                //           ),
                //         ),
                //       );
                //     }
                //   },
                //   padding: EdgeInsets.zero,
                //   minSize: 0,
                //   child: SvgPicture.asset(Assets.svgDotsMenu),
                // ),
              ],
            ),
          ),
          // 20.verticalSpace,
          _buildReplies(commentIndex: commentIndex),
        ],
      ),
    );
  }

  Widget _buildReplies({required int commentIndex}) {
    return Obx(() => (controller
            .commetnModelList.value!.data[commentIndex].replies.isNotEmpty)
        ? Container(
            padding: const EdgeInsets.only(left: 45),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller
                  .commetnModelList.value!.data[commentIndex].replies.length,
              reverse: true,
              itemBuilder: (context, replyIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if (controller
                        //     .commentsList[commentIndex]
                        //     .commentReplies[replyIndex]
                        //     .replyAuthorImageUrl
                        //     .isNotEmpty)
                        //   SizedBox(
                        //     width: 50,
                        //     height: 50,
                        //     child: CircleAvatar(
                        //       backgroundColor: AppColors.whiteBGColor,
                        //       backgroundImage: CachedNetworkImageProvider(
                        //         controller
                        //             .commentsList[commentIndex]
                        //             .commentReplies[replyIndex]
                        //             .replyAuthorImageUrl,
                        //       ),
                        //     ),
                        //   )
                        // else
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.blackBGColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.blackBGColor,
                            child: Text(
                              "Reply comment User Name",
                              // '${controller.commentsList[commentIndex].commentReplies[replyIndex].replyAuthorFirstName[0]}${controller.commentsList[commentIndex].commentReplies[replyIndex].replyAuthorLastName[0]}',
                              style: AppTextStyles.bold.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reply Commetn User Name",
                              // '@${controller.commentsList[commentIndex].commentReplies[replyIndex].replyAuthorUsername}',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 14,
                                color: AppColors.blackBGColor,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            2.verticalSpace,
                            Text(
                              controller.getReplyTimeDifference(
                                commentIndex: commentIndex,
                                replyID: replyIndex,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 12,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    17.verticalSpace,
                    if (controller.commetnModelList.value!.data[commentIndex]
                        .replies[replyIndex].comment!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: LinkifyText(
                          controller.commetnModelList.value!.data[commentIndex]
                              .replies[replyIndex].comment!,
                          textStyle: AppTextStyles.normal.copyWith(
                            fontSize: 14,
                            color: AppColors.blackBGColor,
                          ),
                          linkTypes: const [LinkType.userTag, LinkType.hashTag],
                          linkStyle: AppTextStyles.semiBold.copyWith(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      15.verticalSpace,
                    ],
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CupertinoButton(
                                onPressed: () {
                                  // controller.addLike(
                                  //     commentIndex: commentIndex,
                                  //     isReplay: true,
                                  //     replayIndex: replyIndex);
                                },
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                child: Text(
                                  '${controller.commetnModelList.value!.data[commentIndex].replies[replyIndex].likes ?? 0}   Likes',
                                  style: AppTextStyles.semiBold.copyWith(
                                    color: controller.replayedLikedByMe(
                                            commentIndex: commentIndex,
                                            replayIndex: replyIndex)
                                        ? AppColors.blackBGColor
                                        : AppColors.greyColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              10.horizontalSpace,
                              CupertinoButton(
                                onPressed: () {
                                  // controller.setReplyMode(
                                  //   commentIndex: commentIndex,
                                  //   replyIndex: replyIndex,
                                  // );
                                },
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                child: Text(
                                  'Reply',
                                  style: AppTextStyles.semiBold.copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              20.horizontalSpace,
                              // SizedBox(
                              //   width: MediaQuery.of(Get.context!).size.width * 0.5,
                              //   child: EmojiListWidget(
                              //     emojiList: controller.commentsList[commentIndex]
                              //         .commentReplies[replyIndex].replyEmojiList,
                              //     onEmojiTap: (emoji) {
                              //       controller.addEmojiToReply(
                              //         emoji.emoji,
                              //         commentIndex,
                              //         replyIndex,
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    replyIndex > 0 ? 12.verticalSpace : 0.verticalSpace
                  ],
                );
              },
            ),
          )
        : 0.verticalSpace);
  }
}
