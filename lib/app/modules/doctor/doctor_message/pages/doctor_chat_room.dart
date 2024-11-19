// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_message_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';

class DoctorChatRoom extends StatelessWidget {
  const DoctorChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments["user"];
    return CustomCupertinoButton(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        child: Column(
          // padding: EdgeInsets.zero,
          // shrinkWrap: true,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Conversation(user: user),
                ),
              ),
            ),
            // buildChatComposer()
            Container(
              color: Colors.red,
              child: TextField(
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  fillColor: Colors.red,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Type your message ...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: buildChatComposer(),
    );
  }
}

// Container(
//       color: Colors.red,
//       child: Scaffold(
//         // extendBody: true,
//         resizeToAvoidBottomInset: true,

//         // backgroundColor: AppColors.blackBGColor,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           toolbarHeight: 100,
//           centerTitle: false,
//           title: Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage(
//                   user.avatar!,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Text(
//                 user.name!,
//                 // style: MyTheme.chatSenderName,
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//                 icon: Icon(
//                   Icons.videocam_outlined,
//                   size: 28,
//                 ),
//                 onPressed: () {}),
//             IconButton(
//                 icon: Icon(
//                   Icons.call,
//                   size: 28,
//                 ),
//                 onPressed: () {})
//           ],
//           elevation: 0,
//         ),
//         body:

class User {
  final int? id;
  final String? name;
  final String? avatar;

  User({
    this.id,
    this.name,
    this.avatar,
  });
}

final User currentUser =
    User(id: 0, name: 'You', avatar: 'assets/images/tempImages.png');
final User addison =
    User(id: 1, name: 'Addison', avatar: 'assets/images/tempImages.png');

Container buildChatComposer() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    height: 100,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.grey[500],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isCollapsed: false,
                      isDense: false,
                      border: InputBorder.none,
                      hintText: 'Type your message ...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                Icon(
                  Icons.attach_file,
                  color: Colors.grey[500],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        const CircleAvatar(
          backgroundColor: Colors.red,
          // backgroundColor: MyTheme.kAccentColor,
          child: Icon(
            Icons.mic,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}

class Conversation extends StatelessWidget {
  const Conversation({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemCount: messages.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          final message = messages[index];
          bool isMe = message.sender!.id == currentUser.id;
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(user.avatar!),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: isMe ? Colors.red : Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          )),
                      child: Text(
                        messages[index].text!,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe)
                        const SizedBox(
                          width: 40,
                        ),
                      const Icon(
                        Icons.done_all,
                        size: 20,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        message.time!,
                        // style: MyTheme.bodyTextTime,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

class Message {
  final User? sender;
  final String? avatar;
  final String? time;
  final int? unreadCount;
  final bool? isRead;
  final String? text;

  Message({
    this.sender,
    this.avatar,
    this.time,
    this.unreadCount,
    this.text,
    this.isRead,
  });
}

final List<Message> recentChats = [
  Message(
    sender: addison,
    avatar: 'assets/images/tempImages.png',
    time: '01:25',
    text: "typing...",
    unreadCount: 1,
  ),
];

final List<Message> messages = [
  Message(
    sender: addison,
    time: '12:09 AM',
    avatar: addison.avatar!,
    text: "...",
  ),
  Message(
    sender: currentUser,
    time: '12:05 AM',
    isRead: true,
    text: "I’m going home.",
  ),
  Message(
    sender: currentUser,
    time: '12:05 AM',
    isRead: true,
    text: "See, I was right, this doesn’t interest me.",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar!,
    text: "I sign your paychecks.",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar!,
    text: "You think we have nothing to talk about?",
  ),
  Message(
    sender: currentUser,
    time: '11:45 PM',
    isRead: true,
    text:
        "Well, because I had no intention of being in your office. 20 minutes ago",
  ),
  Message(
    sender: addison,
    time: '11:30 PM',
    avatar: addison.avatar!,
    text: "I was expecting you in my office 20 minutes ago.",
  ),
];

class ChatPage extends StatefulWidget {
  final DoctorMessageModelData doctorMessageModelData;
  const ChatPage({super.key, required this.doctorMessageModelData});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
            // Column(
            //   children: [

            //     const SizedBox(
            //       height: 120,
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    connect();
  }

  String paitentToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI4ZWYzODYwNzdiYTRmMTlkZTU3MzFlMzgzYzk1M2IwZWFmY2I0MTNlNjFmZWIzNDQxZWYzMDlmMDU4OTExYzlhYTY5Mjk3YmQyYWNlMTE1MmVmZGM0ODc2ZDIyN2Y5YWYiLCJzZXNzaW9uVG9rZW4iOiI3NjkxYzdjZTVmODcyZTM2ZjFiYTgxZGIxYjEyMTY2MmVkZTczM2QxZGJkZjU1ZWU5YzBhZGU5ZjA3NDg3M2VkOGU5ZWU3MDI2M2JjZDdmMGQ5ZWZlYTNlYzNkZjdjM2RjYTM1ZmQ1MzUwYWYzY2M1ZmM3YzliODYyOWI3ZWJhYiIsImlhdCI6MTczMTk1NDk1MH0.jUw_d7hGZPS8gVh7k5unC6Ul1xGuSpuRqAudvl-Im1w';

  String docotrToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiJmZTQwYTcwMTQzMGM2YzAwYjMzODYyM2VjN2I0MmVjZWQxN2NkNTNjOTMxZGVkNTczZDVlZjhlNjYyZjIzYmIxZTRlMGJjMzhlNTJlMjZhNmU1N2JhM2MzNDczNDc1MzAiLCJzZXNzaW9uVG9rZW4iOiI4NmMxMzdmZGU4MTdhYzBlNDQ3NTc0OTgwYjhmOTdmOTAxNmYwNGE1ZjhmNzM0MDQ2MGQzNDgxYzRkNTM5OWJkZDM4NjkyYmFlNjllNzdjYmQzZTRhZDQ3MmE1NTc4M2FkMDUxYWExNzgyZGFlMTllNTFkMzVhY2QwYTAxMjMxOCIsImlhdCI6MTczMTk1NTA5NH0.ROFaenIzOYhfb6LQ-Mb6gKjFHYVMr1BgIbt8bVkz8PM';
  Future<void> connect() async {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("${AppTokens.apiURl}", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.emit("join_conversation", [
      widget.doctorMessageModelData.id,
      "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
    ]);
    print(
      Get.find<DoctorHomeController>().userModel.value!.token!,
    );
    print(widget.doctorMessageModelData.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        // setMessage("destination", msg["message"]);
        // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    socket.onConnectError((val) {
      print(val);
    });
    print(socket.connected);
  }

  getData() {
    try {
      print("Testt");

      socket.onConnect((data) {
        print("Connected");
        print(data);
        socket.on("new_message", (msg) {
          print(msg);
          // setMessage("destination", msg["message"]);
          // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  joinChat() {
    print("Chhecc");
    socket.emit("join_conversation", [
      widget.doctorMessageModelData.id!,
      "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
    ]);
  }

  sendMessage() {
    Map<String, String> message = {
      'conversationId': widget.doctorMessageModelData.id!,
      "token":
          "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      "text": "Testttff",
    };
    socket.emit("send_message", message);
  }

  newMeasa() {
    print("New");
    socket
        .on(
            "new_message",
            (message) => {
                  print(message),
                  print("New Message"),
                })
        .printError();
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  // connect();
                  // joinChat();
                  // sendMessage();
                  newMeasa();
                  // getData();
                  // sendMessage();
                },
                child: const Text(
                  'Fiona',
                  style: TextStyle(
                      fontSize: 28,
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
                child: const Icon(
                  Icons.call,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(
                  Icons.videocam,
                  size: 25,
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
        padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              time: '18.00',
            ),
            _itemChat(
              chat: 0,
              message: 'Okey 🐣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: 'It has survived not only five centuries, 😀',
              time: '18.00',
            ),
            _itemChat(
              chat: 0,
              message:
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. 😎',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message:
                  'The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
            _itemChat(
              avatar: 'assets/images/tempImages.png',
              chat: 1,
              message: '😅 😂 🤣',
              time: '18.00',
            ),
          ],
        ),
      ),
    );
  }

  // 0 = Send
  // 1 = Recieved
  _itemChat({int? chat, String? avatar, message, time}) {
    return Row(
      mainAxisAlignment:
          chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        avatar != null
            ? Avatar(
                image: avatar,
                size: 50,
              )
            : Text(
                '$time',
                style: TextStyle(color: Colors.grey.shade400),
              ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: chat == 0 ? Colors.indigo.shade100 : Colors.indigo.shade50,
              borderRadius: chat == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
            ),
            child: Text('$message'),
          ),
        ),
        chat == 1
            ? Text(
                '$time',
                style: TextStyle(color: Colors.grey.shade400),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _formChat() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.whiteBGColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 10),
          child: TextField(
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
              prefixIcon: Container(
                // color: Colors.red,
                width: 14 * SizeConfig.widthMultiplier,
                margin: EdgeInsets.only(
                    left: 4 * SizeConfig.widthMultiplier,
                    right: 4 * SizeConfig.widthMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/camer_up.svg",
                      height: 3 * SizeConfig.heightMultiplier,
                    ),
                    SizedBox(width: 1 * SizeConfig.widthMultiplier),
                    SvgPicture.asset(
                      "assets/icons/mic_icon.svg",
                      height: 3 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ),
              suffixIcon: Container(
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

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  const Avatar(
      {super.key,
      this.image,
      this.size = 50,
      this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
