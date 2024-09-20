import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/model/user.dart';
import 'package:dio/dio.dart';
import 'package:login/model/user_response.dart';
import 'package:login/pages/dashboard_page.dart';

class LoginControllers extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _message = '';
  var response;
  UserResponse userResponse = UserResponse();

  Future<void> submit() async {
    User user = User(
        username: usernameController.text.trim(),
        password: passwordController.text.trim());

    bool result = validateResult(user);
    if (result) {
      bool serverResponse = await authenticateUser(user);
      if (serverResponse) {
        await showMessage(
            context: Get.context!,
            title: "Success",
            message: "User Login Successfully");
      } else {
        await showMessage(
            context: Get.context!,
            title: "Error",
            message: "Incorrect Username or Password");
      }
    } else {
      await showMessage(
          context: Get.context!, title: "Error", message: _message);
    }
  }

  bool validateResult(User user) {
    if (user.username == null || user.password == null) {
      _message = "Username or Password can not be empty";
      return false;
    }
    if (user.username.toString().isEmpty) {
      _message = "Username can not be empty";
      return false;
    }
    if (user.password.toString().isEmpty) {
      _message = "Password can not be Empty";
      return false;
    }
    return true;
  }

  Future<bool> authenticateUser(User user) async {
    Dio dio = Dio();
    String baseUrl = "https://dummyjson.com/auth/login";
    //correct user = 'emilys'
    // correct password = 'emilyspass'
    try {
      Map<String, dynamic> requestData = {
        "username": user.username,
        "password": user.password
      };
       response = await dio.post(baseUrl, data: requestData);
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  showMessage(
      {required BuildContext context,
      required String title,
      required String message}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  if (title == "Success") {
                   userResponse= UserResponse.fromJson(response.data);
                   print(response.data);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DashboardPage(
                              userResponse: userResponse,
                            )));
                  } else {
                    Get.back();
                  }
                },
              )
            ],
          );
        });
  }
}
