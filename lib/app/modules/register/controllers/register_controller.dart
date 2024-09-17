import 'dart:io';

import 'package:chatapp/app/routes/app_pages.dart';
import 'package:chatapp/helper/log_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../helper/handleException.dart';
import '../../../../repository/api_services.dart';
import '../../auth/widgets/PresenceService.dart';

class RegisterController extends GetxController {
  final obscureText = true.obs;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Rx<File?> pickedImage = Rx<File?>(null);

  void pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (image == null) {
      Get.snackbar('Error', 'No image selected');
      return;
    }
    pickedImage.value = File(image.path);
  }

  // ApiServices instance
  final ApiServices apiServices = ApiServices();

  // Reactive variables for loading states and errors
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  //firebase
  final firebase = FirebaseAuth.instance;
  Future signUp(String name, String email, String password) async {
    if (pickedImage.value == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }
    isLoading.value = true;
    try {
      // Create user with email and password
      final user = await firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      // Prepare Firebase Storage reference
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${user.user!.uid}.jpg');
      OneSignal.login(user.user!.uid);
      final uploadTask = storageRef.putFile(pickedImage.value!);
      // Wait for upload to complete
      await uploadTask.whenComplete(() async {
        if (uploadTask.snapshot.state == TaskState.success) {
          // Get image URL after successful upload
          final imgUrl = await storageRef.getDownloadURL();
          Log.w('Image uploaded successfully: $imgUrl');
          // Update user presence globally
          PresenceService.updateUserPresence(user.user!.uid);
          // Store user details in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.user!.uid)
              .set({
            'username': name,
            'email': email,
            'imgUrl': imgUrl,
            'online': true, // Initially set the user as online
            'last_seen': Timestamp.now(), // Store the last seen timestamp
          });
          // Update user presence globally
          PresenceService.updateUserPresence(user.user!.uid);
          Get.snackbar('Registration', 'Registered Successfully');
          Get.toNamed(Routes.HOMEE);
        } else {
          throw Exception("Image upload failed: ${uploadTask.snapshot.state}");
        }
      }).catchError((error) {
        Log.e('Image upload failed: $error');
        Get.snackbar('Error', 'Image upload failed: $error');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.snackbar('Registration', 'Email Already in Use');
      }
    } catch (e) {
      Log.e('Error during registration: $e');
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

    @override
    void onClose() {
      // Dispose controllers when no longer needed
      usernameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      super.onClose();
    }



  }


