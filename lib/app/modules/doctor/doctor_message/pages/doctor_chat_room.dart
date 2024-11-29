// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/controller/doctor_chat_room_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_chat_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_message_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/widget/chat_title.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DocotrChatPage extends StatefulWidget {
  const DocotrChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DocotrChatPageState createState() => _DocotrChatPageState();
}

final ctrl = Get.put(DoctorChatRoomController());

class _DocotrChatPageState extends State<DocotrChatPage> {
  @override
  void dispose() {
    super.dispose();
    leaveConversation();
    socket.disconnect();

    socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _topChat(),
            _bodyChat(),
            _formChat(),
          ],
        ),
      ),
    );
  }

  late io.Socket socket;
  late DoctorMessageModelData userMessageModelData;
  @override
  void initState() {
    super.initState();
    ctrl.hasScrolled.value = false;
    userMessageModelData = Get.arguments[0];
    connectAndListen();
    ctrl.getUserChatConversation(userMessageModelData.id!);
  }

  StreamSocket streamSocket = StreamSocket();

  void connectAndListen() {
    print(userMessageModelData.id!);
    socket = io.io(AppTokens.apiURl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.connect();
    joinChat();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on("connect", (data) {
      print("Connected to Socket.IO server: ${socket.id}");
    });

    //When an event recieved from server, data is added to the stream
    socket.on('new_message', (data) {
      print("TEsttsffs");
      print(data);
      String jsonString = '''$data''';
      log(jsonString.toString());
      final encode = jsonEncode(data);
      Map<String, dynamic> jsonData = jsonDecode(encode);
      print(jsonData);
      print("testtdff");

      final chatData = DoctorChatModel.fromJson(jsonData);

      // print(ctrl.userChatList.length);
      // ctrl.userChatList.add(chatData);
      print("Checkin ${ctrl.userChatList.length}");
      // streamSocket.addResponse(data);
      // print(data);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  getData() {
    try {
      socket.onConnect((data) {
        print("Connected");
        print(data);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  joinChat() {
    socket.emit(
      "join_conversation",
      {
        "conversationID": userMessageModelData.id!,
        "token":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
  }

  leaveConversation() {
    socket.emit("join_conversation", {
      "conversationID": userMessageModelData.id!,
      "token":
          "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
    });
  }

  sendMessage() {
    socket.emit(
      "send_message",
      {
        "conversationID": userMessageModelData.id!,
        "token":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        "text": "HCehhehfhr",
      },
    );
  }

  _topChat() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomCupertinoButton(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 2.2 * SizeConfig.heightMultiplier,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 2 * SizeConfig.widthMultiplier),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.49,
                child: Text(
                  "${userMessageModelData.patient!.firstNameEn!.capitalizeFirst!} ${userMessageModelData.patient!.lastNameEn!.capitalizeFirst!}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 2.5 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: Icon(
                  Icons.call,
                  size: 2.2 * SizeConfig.heightMultiplier,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 2 * SizeConfig.heightMultiplier),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: Icon(
                  Icons.videocam,
                  size: 2.2 * SizeConfig.heightMultiplier,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyChat() {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(
              left: 2.5 * SizeConfig.widthMultiplier,
              right: 2.5 * SizeConfig.widthMultiplier,
              top: 0),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            color: Colors.white,
          ),
          child: Obx(
            () => ctrl.isLoading.value
                ? const LoadingWidget()
                : ctrl.userChatList.isEmpty
                    ? const NoDataWidget(title: "No chat available")
                    : ListView.builder(
                        controller: ctrl.scrollController.value,
                        shrinkWrap: true,
                        itemCount: ctrl.userChatList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: index == ctrl.userChatList.length - 1
                                    ? 14
                                    : 0),
                            child: ChatTitle(
                              showImage: Get.find<DoctorHomeController>()
                                          .userModel
                                          .value!
                                          .user!
                                          .id ==
                                      ctrl.userChatList[index].senderId!.id!
                                  ? false
                                  : true,
                              firstName: Get.find<DoctorHomeController>()
                                          .userModel
                                          .value!
                                          .user!
                                          .id ==
                                      ctrl.userChatList[index].senderId!.id!
                                  ? ctrl
                                      .userChatList[index].senderId!.firstName!
                                  : ctrl.userChatList[index].receiverId!
                                      .firstName!,
                              lastName: Get.find<DoctorHomeController>()
                                          .userModel
                                          .value!
                                          .user!
                                          .id ==
                                      ctrl.userChatList[index].senderId!.id!
                                  ? ctrl
                                      .userChatList[index].senderId!.lastNameEn!
                                  : ctrl.userChatList[index].receiverId!
                                      .lastNameEn!,
                              isImageNull: Get.find<DoctorHomeController>()
                                          .userModel
                                          .value!
                                          .user!
                                          .id ==
                                      ctrl.userChatList[index].senderId!.id!
                                  ? ctrl.userChatList[index].senderId!
                                              .profilePicture ==
                                          null
                                      ? true
                                      : false
                                  : ctrl.userChatList[index].receiverId!
                                              .profilePicture ==
                                          null
                                      ? true
                                      : false,
                              avatar: Get.find<DoctorHomeController>()
                                          .userModel
                                          .value!
                                          .user!
                                          .id ==
                                      ctrl.userChatList[index].senderId!.id!
                                  ? ctrl.userChatList[index].senderId!
                                              .profilePicture ==
                                          null
                                      ? ""
                                      : ctrl.userChatList[index].senderId!
                                          .profilePicture!.bg!
                                  : ctrl.userChatList[index].receiverId!
                                              .profilePicture ==
                                          null
                                      ? ""
                                      : ctrl.userChatList[index].receiverId!
                                          .profilePicture!.bg,
                              chat: Get.find<DoctorHomeController>()
                                          .userModel
                                          .value!
                                          .user!
                                          .id ==
                                      ctrl.userChatList[index].senderId!.id!
                                  ? 0
                                  : 1,
                              message: ctrl.userChatList[index].text,
                              time: formateDate(ctrl
                                  .userChatList[index].updatedAt!
                                  .toString()),
                            ),
                          );
                        },
                      ),
          )),
    );
  }

  formateDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  TextEditingController message = TextEditingController();

  Widget _formChat() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.whiteBGColor,
        child: Padding(
          padding: EdgeInsets.only(
              left: 2.5 * SizeConfig.widthMultiplier,
              right: 2.5 * SizeConfig.widthMultiplier,
              top: 1 * SizeConfig.heightMultiplier,
              bottom: 1 * SizeConfig.heightMultiplier),
          child: TextField(
            controller: message,
            style: AppTextStyles.normal.copyWith(
              color: AppColors.blackBGColor,
              fontWeight: FontWeight.w500,
              fontSize: 1.6 * SizeConfig.heightMultiplier,
            ),
            decoration: InputDecoration(
              hintText: 'Type your message...',
              hintStyle: AppTextStyles.normal.copyWith(
                color: const Color(0xff535353),
                fontSize: 1.6 * SizeConfig.heightMultiplier,
              ),
              // prefixIcon: Container(
              //   // color: Colors.red,
              //   width: 14 * SizeConfig.widthMultiplier,
              //   margin: EdgeInsets.only(
              //       left: 4 * SizeConfig.widthMultiplier,
              //       right: 4 * SizeConfig.widthMultiplier),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       SvgPicture.asset(
              //         "assets/icons/camer_up.svg",
              //         height: 3 * SizeConfig.heightMultiplier,
              //       ),
              //       SizedBox(width: 1 * SizeConfig.widthMultiplier),
              //       SvgPicture.asset(
              //         "assets/icons/mic_icon.svg",
              //         height: 3 * SizeConfig.heightMultiplier,
              //       ),
              //     ],
              //   ),
              // ),
              suffixIcon: CustomCupertinoButton(
                onTap: () {
                  if (message.text.isNotEmpty) {
                    sendMessage();
                    message.clear();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    "Send",
                    style: AppTextStyles.bold.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff535353),
                      fontSize: 1.7 * SizeConfig.heightMultiplier,
                    ),
                  ),
                ),
              ),
              filled: true,
              fillColor: const Color(0xffF7F7F8),
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffF7F7F8)),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffF7F7F8)),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffF7F7F8)),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffF7F7F8)),
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffF7F7F8)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
