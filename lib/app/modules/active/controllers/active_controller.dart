import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../model/userModel.dart';

class ActiveController extends GetxController {
// Observable list of active users
  var activeUsers = <UserModel>[].obs;

  // Fetch stream of active users
  Stream<List<UserModel>> getActiveUsersStream() {
    final currentUser = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .where('online', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => UserModel.fromSnapshot(doc))
          .where((user) => user.id != currentUser!.uid) // Exclude current user
          .toList();
    });
  }

  // Listen to the stream and update the observable list
  @override
  void onInit() {
    super.onInit();
    getActiveUsersStream().listen((users) {
      activeUsers.assignAll(users); // Update the observable list
    });
  }
}
