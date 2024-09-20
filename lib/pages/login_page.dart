import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/controller/login_controllers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginControllers controllers = Get.put(LoginControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              const SizedBox(
                height: 20,
              ),
              _inputBox(
                  hint: 'Username', controller: controllers.usernameController),
              const SizedBox(
                height: 20,
              ),
              _inputBox(
                  hint: 'Password', controller: controllers.passwordController),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Get.width / 2,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async{
                    await controllers.submit();
                  },
                  child: const Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputBox(
      {required String hint, required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 1)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}
