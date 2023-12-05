import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Center(
        child: const Text('Welcome to Admin Home'),
      ),
    );
  }
}