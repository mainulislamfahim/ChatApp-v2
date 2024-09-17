import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class PresenceService {
  /// Function to update the user's presence in Firebase Firestore
  static void updateUserPresence(String userId) {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Monitor connection state using Realtime Database for presence management
    DatabaseReference connectedRef =
        FirebaseDatabase.instance.ref().child(".info/connected");

    connectedRef.onValue.listen((event) {
      if (event.snapshot.value == true) {
        // User is online, update Firestore
        userRef.update({
          'online': true,
          'last_seen': FieldValue.serverTimestamp(),
        });

        // Handle user disconnection by setting 'online' to false
        // userRef.onDisconnect().update({
        //   'online': false,
        //   'last_seen': FieldValue.serverTimestamp(),
        // });
      }
    });
  }
}
