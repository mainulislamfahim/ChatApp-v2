import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../helper/handleException.dart';
import '../../../../helper/log_printer.dart';
import '../../../../repository/api_services.dart';
import '../../../../services/local_store_config.dart';
import '../../../routes/app_pages.dart';
import '../../auth/widgets/PresenceService.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ApiServices instance
  final ApiServices apiServices = ApiServices();

  final firebase = FirebaseAuth.instance;
  Future login(String email, String password) async{
    try{
      final user = await firebase.signInWithEmailAndPassword(email: email, password: password);
      OneSignal.login(user.user!.uid);
      // Update user presence globally
      PresenceService.updateUserPresence(user.user!.uid);
      Get.snackbar('Login', 'Logged In Successfully');
      Get.toNamed(Routes.HOMEE);
    }on FirebaseAuthException catch(e) {
      if(e.code == 'invalid-email'){
        Get.snackbar('Login', 'Invalid Email');
      } else if(e.code == 'wrong-password'){
        Get.snackbar('Login', 'Incorrect Password');
      }
    }
  }

  // Reactive variables for loading states and errors
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final obscureText = true.obs;


}