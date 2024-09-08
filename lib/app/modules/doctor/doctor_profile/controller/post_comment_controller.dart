import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/comment_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

class PostCommentController extends GetxController {
  final String? postID;
  PostCommentController({this.postID});

  RxBool commentsLoading = false.obs;
  Rxn<CommentModel> commetnModelList = Rxn();
  final selectedCommentIndex = RxInt(-1);
  final commentTextController = RichTextController(
    targetMatches: [
      MatchTargetItem(
        regex: RegExp(r'\B@[a-zA-Z\d._]+\b'),
        style: AppTextStyles.medium.copyWith(
          color: AppColors.primaryColor,
          fontSize: 15,
        ),
      )
    ],
    onMatch: (data) {},
  );

  final commentFieldFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getPostComment();
  }

  getPostComment() async {
    commentsLoading.value = true;
    final response = await ApiService.getwithUserToken(
      endPoint: '${AppTokens.apiURl}/comments/$postID',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      commetnModelList.value = CommentModel.fromJson(jsonData);
    }
    commentsLoading.value = false;
  }

  sendCommentOnPost() async {
    try {
      final response = await ApiService.postWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/comments/$postID',
        body: {
          "comment": commentTextController.text.trim(),
          "parentComment": ""
        },
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = jsonDecode(response.body);
          print(response.statusCode);
        } else {
          printInfo(
              info: "Error While Updating Assistant Address ${response.body}");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void setReplyMode({
    required int commentIndex,
    int replyIndex = -1,
  }) async {
    selectedCommentIndex.value = commentIndex;
    if (replyIndex == -1) {
      // CChnage Commetn To your Name
      commentTextController.text =
          '@${commetnModelList.value!.data[selectedCommentIndex.value].comment} ';
    } else {
      commentTextController.text =
          '@${commetnModelList.value!.data[selectedCommentIndex.value].replies[replyIndex].comment} ';
    }
    commentTextController.selection = TextSelection.fromPosition(
      TextPosition(offset: commentTextController.value.text.length),
    );

    commentFieldFocusNode.requestFocus();
  }

  String getCommentTimeDifference({required int commentIndex}) {
    final creationTime = commetnModelList.value!.data[commentIndex].createdAt!;
    final now = Timestamp.now().toDate();
    final years = (now.difference(creationTime).inMinutes / 525600).round();
    final months = (now.difference(creationTime).inMinutes / 43800).round();
    final days = now.difference(creationTime).inDays;
    final hours = now.difference(creationTime).inHours;
    final minutes = now.difference(creationTime).inMinutes;
    final seconds = now.difference(creationTime).inSeconds;

    if (years != 0) {
      return '${years}y ago';
    } else {
      if (months != 0) {
        return '${months}M ago';
      } else {
        if (days != 0) {
          return '${days}d ago';
        } else {
          if (hours != 0) {
            return '${hours}h ago';
          } else {
            if (minutes != 0) {
              return '${minutes}min ago';
            } else {
              if (seconds != 0) {
                return '${seconds}s ago';
              } else {
                return 'Just Now';
              }
            }
          }
        }
      }
    }
  }

  bool commentLikedByMe({required int commentIndex}) {
    // if (commetnModelList.value.data[commentIndex].user!.id! !=
    //     null) if (commentsList[commentIndex].likesInfo!.isNotEmpty)
    //   for (final value in commentsList[commentIndex].likesInfo!) {
    //     if (value == Get.find<AuthController>().user!.uid) return true;
    //   }
    return false;
  }

  String getReplyTimeDifference({
    required int commentIndex,
    required int replyID,
  }) {
    final creationTime =
        commetnModelList.value!.data[commentIndex].replies[replyID].createdAt!;
    final now = Timestamp.now().toDate();
    final years = (now.difference(creationTime).inMinutes / 525600).round();
    final months = (now.difference(creationTime).inMinutes / 43800).round();
    final days = now.difference(creationTime).inDays;
    final hours = now.difference(creationTime).inHours;
    final minutes = now.difference(creationTime).inMinutes;
    final seconds = now.difference(creationTime).inSeconds;

    if (years != 0) {
      return '${years}y ago';
    } else {
      if (months != 0) {
        return '${months}M ago';
      } else {
        if (days != 0) {
          return '${days}d ago';
        } else {
          if (hours != 0) {
            return '${hours}h ago';
          } else {
            if (minutes != 0) {
              return '${minutes}min ago';
            } else {
              if (seconds != 0) {
                return '${seconds}s ago';
              } else {
                return 'Just Now';
              }
            }
          }
        }
      }
    }
  }

  bool replayedLikedByMe(
      {required int commentIndex, required int replayIndex}) {
    // if (commentsList[commentIndex].commentReplies[replayIndex].likesInfo !=
    //     null) if (commentsList[
    //         commentIndex]
    //     .commentReplies[replayIndex]
    //     .likesInfo!
    //     .isNotEmpty)
    //   for (final value in commentsList[commentIndex]
    //       .commentReplies[replayIndex]
    //       .likesInfo!) {
    //     if (value == Get.find<AuthController>().user!.uid) return true;
    //   }
    return false;
  }
}
