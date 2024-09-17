import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../helper/log_printer.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();


  String getChatDocId() {
    final receiverId = Get.arguments;
    final user = FirebaseAuth.instance.currentUser;
    return user!.uid.compareTo(receiverId) < 0
        ? '${user.uid}_$receiverId'
        : '${receiverId}_${user.uid}';
  }

  void sendMessage() async {
    final msg = messageController.text;
    if(msg.trim().isEmpty){
      return;
    }
    FocusScope.of(Get.context!).unfocus();
    messageController.clear();

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    await FirebaseFirestore.instance.collection('chats').doc(getChatDocId()).collection('messages').add({
      'text': msg,
      'username': userData.data()!['username'],
      'createdAt': Timestamp.now(),
      'userID': user.uid,
      'userImage': userData.data()!['imgUrl'],
    });
  }

  void setUpPushNotification() async{
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  @override
  void onInit() {
    getChatDocId();
    setUpPushNotification();
    super.onInit();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

}
