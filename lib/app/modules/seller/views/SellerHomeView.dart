import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerHomeView extends StatelessWidget {
  const SellerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Home'),
      ),
      body: Center(
        child: const Text('Welcome to Seller Home'),
      ),
    );
  }
}
