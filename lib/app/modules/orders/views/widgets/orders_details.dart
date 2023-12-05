import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/modules/orders/controllers/orders_controller.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/utils/constants.dart';

class OrderDetailsView extends StatelessWidget {
  final List<Map<String, dynamic>> orderDetailsList;

  OrderDetailsView({required this.orderDetailsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                const ScreenTitle(
                  title: 'Order Details',
                ),
                Spacer(),
                RoundedButton(
                  onPressed: () => Get.back(),
                  child: SvgPicture.asset(
                    Constants.backArrowIcon,
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderDetailsList.length,
              itemBuilder: (context, index) {
                final orderDetail = orderDetailsList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${orderDetail['name']}'),
                    Text('Price: ${orderDetail['price']}'),
                    Text('Quantity: ${orderDetail['quantity']}'),
                    Text('Total: ${orderDetail['total']}'),
                    // Add more widgets for other order details
                    Divider(), // Optional divider between order details
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}