import 'package:flutter/material.dart';
import 'package:login/model/user_response.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.userResponse});

  final UserResponse userResponse;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("first name:${widget.userResponse.firstName}"),
              Text("last name:${widget.userResponse.lastName}"),
              Text("userName:${widget.userResponse.username}"),
              Text("id:${widget.userResponse.id}"),
              Text("email:${widget.userResponse.email}"),
              Text("gender:${widget.userResponse.gender}"),
            ],
          ),
        ),
      ),
    );
  }
}
