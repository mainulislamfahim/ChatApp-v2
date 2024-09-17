import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RecentMessageController extends GetxController {
  /// Function to update the user's presence in Firebase Firestore
  void updateUserPresence(String userId) {
    final DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // Monitor connection state (for Firebase Realtime Database presence management)
    DatabaseReference connectedRef = FirebaseDatabase.instance.ref().child(".info/connected");

    connectedRef.onValue.listen((event) {
      if (event.snapshot.value == true) {
        // User is online, update Firestore
        userRef.update({
          'online': true,
          'last_seen': FieldValue.serverTimestamp(), // Firestore equivalent of Timestamp.now()
        });

        // Set 'online' to false and update 'last_seen' when the user disconnects
        // userRef..onDisconnect().update({
        //   'online': false,
        //   'last_seen': FieldValue.serverTimestamp(),
        // });
      }
    });
  }
}
