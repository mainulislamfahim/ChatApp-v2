import 'package:chatapp/app/modules/chat/controllers/chat_controller.dart';
import 'package:chatapp/helper/log_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeeController extends GetxController with GetSingleTickerProviderStateMixin{
  final messageController = TextEditingController();
  final list = [].obs;
  late TabController tabController;
  RxInt selectedTabIndex = 0.obs;
  // Update selected tab and animate to it
  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
    update();
  }

  void sendMessage() async {
    final msg = messageController.text;
    if (msg.trim().isEmpty) {
      return;
    }
    FocusScope.of(Get.context!).unfocus();
    messageController.clear();

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': msg,
      'username': userData.data()!['username'],
      'createdAt': Timestamp.now(),
      'userID': user.uid,
      'userImage': userData.data()!['imgUrl'],
    });
  }


  void setupFCM() async {
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
    final token = await fcm.getToken();
    Log.i('Token : $token');
  }

  @override
  void onInit() {
    // getUser();
    // setupFCM();
    tabController = TabController(
      length: 2,
      vsync: this,
    );

    // Get.put(ChatController());
    super.onInit();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }


  // void getUser() async {
  //   try {
  //     // Retrieve the entire 'users' collection
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .get();
  //     final allUsers = querySnapshot.docs.map((doc) => doc.data()).toList();
  //     list.value = allUsers;
  //     debugPrint('Users: $allUsers');
  //   } catch (e) {
  //     debugPrint('Error fetching users: $e');
  //   }
  // }

}
