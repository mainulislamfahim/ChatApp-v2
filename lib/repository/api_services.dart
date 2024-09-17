
import 'package:chatapp/repository/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../helper/log_printer.dart';

abstract class IApiService {
  // Future<SignInModel> signIn(String email, String password);
  // declare abstract functions

}

class ApiServices implements IApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoint.baseUrl, // Replace with your actual API base URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // @override
  // Future<SignInModel> signIn(String email, String password) async {
  //   final Map<String, dynamic> data = {
  //     'email': email,
  //     'password': password,
  //   };
  //   return _handleRequest<SignInModel>(
  //       () => _dio.post(ApiEndpoint.login, data: data),
  //       (dynamic data) => SignInModel.fromJson(data),
  //       'Sign In');
  // }
  //
  // @override
  // Future<SignUpModel> signUp(
  //     String username, String email, String password) async {
  //   final Map<String, dynamic> data = {
  //     'username': username,
  //     'email': email,
  //     'password': password,
  //   };
  //   return _handleRequest<SignUpModel>(
  //       () => _dio.post(ApiEndpoint.register, data: data),
  //       (dynamic data) => SignUpModel.fromJson(data),
  //       'Register');
  // }
  //
  // @override
  // Future<AllUsers> getUsers() async {
  //   return _handleRequest<AllUsers>(() => _dio.get(ApiEndpoint.allUser),
  //       (dynamic data) => AllUsers.fromJson(data), 'Users');
  // }
}

Future<T> _handleRequest<T>(Future<Response<dynamic>> Function() request,
    T Function(dynamic) mapper, String apiName) async {
  try {
    final response = await request();
    // Log.i('Print Status Code');
    // Log.i(response.statusCode);
    // Log.i(response.data);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 422) {
      debugPrint('Api Name: $apiName');
      return mapper(response.data);
    } else {
      debugPrint('Api Name: $apiName');

      throw ApiException('Failed to load data: ${response.statusCode}',
          statusCode: response.statusCode!);
    }
  } catch (e) {
    debugPrint("API HANDLER ERROR:  ${e.toString()}");
    throw ApiException('Failed to load data: $e', statusCode: 500);
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, {this.statusCode = 500});
}
