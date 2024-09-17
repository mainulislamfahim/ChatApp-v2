import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helper/app_text_style.dart';
import '../../../../helper/appbar_title.dart';
import '../../../../helper/loading_animation_widget.dart';
import '../../homee/messageBubble.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    final authenticateUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(controller.getChatDocId())
            .collection('messages')
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingAnimationWidget();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: AppTextStyle(
                text: 'No messages',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          } else {
            final loadMessage = snapshot.data!.docs;
            return ListView.builder(
              itemCount: loadMessage.length,
              itemBuilder: (_, item) {
                final chatMessage = loadMessage[item].data();
                final nextChatMessage = item + 1 < loadMessage.length
                    ? loadMessage[item + 1].data()
                    : null;
                final currentUserID = chatMessage['userID'];
                final nextUserID = nextChatMessage != null ? nextChatMessage['userID'] : null;
                final nextUserSame = currentUserID == nextUserID;
                if (nextUserSame) {
                  return MessageBubble.next(
                    message: chatMessage['text'],
                    isMe: authenticateUser!.uid == currentUserID,
                  );
                } else {
                  return MessageBubble.first(
                    userImage: chatMessage['userImage'],
                    username: chatMessage['username'],
                    message: chatMessage['text'],
                    isMe: authenticateUser!.uid == currentUserID,
                  );
                }
              },
            );
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10, // Adjusts padding when the keyboard appears
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  controller.sendMessage();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
