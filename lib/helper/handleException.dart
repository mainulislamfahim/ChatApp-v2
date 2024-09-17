import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../repository/api_services.dart';

handleException(dynamic error) {
  if (error is ApiException) {
    if (error.statusCode == 401) {
      Get.snackbar("Error", "Unauthorized access. Please log in again.");
    } else if (error.statusCode == 404) {
      Get.snackbar("Error", "Requested resource not found.");
    } else if (error.statusCode == 500) {
      Get.snackbar("Error", "Internal server error. Please try again later.");
    } else if (error.statusCode == 400) {
      Get.snackbar("Error", "Bad Request. Please try again later.");
    } else {
      Get.snackbar("Error", "Failed to fetch products. Error: ${error.message}");
    }
  } else if (error is SocketException) {
    Get.snackbar("Error", "No internet connection.");
  } else if (error is TimeoutException) {
    Get.snackbar("Error", "Request timed out. Please try again later.");
  } else {
    Get.snackbar("Error", "Failed to fetch products.");
  }
}