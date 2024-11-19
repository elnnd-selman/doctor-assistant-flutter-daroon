import 'package:daroon_doctor/app/modules/doctor/doctor_message/controller/doctor_message_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_message_model.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/pages/doctor_chat_room.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:get/get.dart';

class DoctorMessageScreen extends GetView<DoctorMessageController> {
  const DoctorMessageScreen({super.key});

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
            "Message",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              _buildPatientTextField(),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              controller.isLoading.value
                  ? const LoadingWidget()
                  : controller.doctorConversationList.isEmpty
                      ? const Text("vvfr")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: controller.doctorConversationList.length,
                          itemBuilder: (context, int index) {
                            // final allChat = allChats[index];
                            return _buildChatContainer(
                                controller.doctorConversationList[index],
                                context);
                          }),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildPatientTextField() {
    return TextFormField(
      style: AppTextStyles.medium.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.blackBGColor,
      ),
      cursorColor: Colors.black12,
      cursorWidth: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
        fillColor: const Color(0xffF7F7F8),
        filled: true,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.secondaryborderColor, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.secondaryborderColor, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.secondaryborderColor, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.secondaryborderColor, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.secondaryborderColor, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(20),
          child: SvgPicture.asset(
            Assets.serachIcon,
            colorFilter: const ColorFilter.mode(
                AppColors.lighttextColor, BlendMode.srcIn),
          ),
        ),
        isDense: true,
        hintText: "Search Patient",
        hintStyle: AppTextStyles.medium.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: const Color(0xff787B80),
        ),
      ),
    );
  }
}

CustomCupertinoButton _buildChatContainer(
  DoctorMessageModelData doctorMessageModelData,
  BuildContext context,
) {
  return CustomCupertinoButton(
    onTap: () {
      Get.to(() => ChatPage(
            doctorMessageModelData: doctorMessageModelData,
          ));
      // Get.toNamed(Routes.doctorChatRoom, arguments: {
      //   "user": allChat.sender!,
      // });
    },
    child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  doctorMessageModelData.patient!.profilePicture!.md!),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doctorMessageModelData.patient!.firstName!,
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackBGColor,
                    fontSize: SizeConfig.heightMultiplier * 1.8,
                  ),
                ),
                Text(
                  doctorMessageModelData.messages.isEmpty
                      ? '--'
                      : doctorMessageModelData.messages[0],
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff707281),
                    fontSize: SizeConfig.heightMultiplier * 1.4,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ? const Icon(
                //     Icons.done_all,
                //     color: AppColors.primaryColor,
                //   )
                // :
                CircleAvatar(
                  radius: 1.2 * SizeConfig.heightMultiplier,
                  backgroundColor: AppColors.primaryColor,
                  child: Center(
                    child: Text(
                      '1',
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteBGColor,
                        fontSize: SizeConfig.heightMultiplier * 1.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "am",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff707281),
                    fontSize: SizeConfig.heightMultiplier * 1.2,
                  ),
                )
              ],
            ),
          ],
        )),
  );
}

final User angel =
    User(id: 2, name: 'Angel', avatar: 'assets/images/tempImages.png');

final User deanna =
    User(id: 3, name: 'Deanna', avatar: 'assets/images/tempImages.png');

final List<Message> allChats = [
  Message(
    sender: addison,
    avatar: 'assets/images/tempImages.png',
    time: '12:59',
    text: "No! I just wanted",
    unreadCount: 0,
    isRead: true,
  ),
  Message(
    sender: deanna,
    avatar: 'assets/images/tempImages.png',
    time: '10:41',
    text: "You did what?",
    unreadCount: 1,
    isRead: false,
  ),
  Message(
    sender: deanna,
    avatar: 'assets/images/tempImages.png',
    time: '10:16',
    text: "May I ask you something?",
    unreadCount: 2,
    isRead: false,
  ),
];
