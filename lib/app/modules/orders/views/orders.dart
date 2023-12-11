import 'package:ecommerce_app/app/modules/orders/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersView extends StatelessWidget {
  final OrdersController _ordersController = Get.put(OrdersController());

  OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis compras',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<OrdersController>(
          builder: (controller) => ListView(
            children: [
              SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.ordersList.length,
                itemBuilder: (context, index) {
                  final order = controller.ordersList[index];
                  return GestureDetector(
                    onTap: () {
                      _ordersController
                          .fetchOrderDetails(order['id'].toString());
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('Order ${order['id']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${order['date_order']}'),
                            Text('Repartidor: ${order['repartidor']}'),
                          ],
                        ),
                        trailing: Text('Status: ${order['status']}'),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              CustomButton(
                text: 'Actuallizar',
                onPressed: () {
                  _ordersController.fetchOrdersData();
                },
                fontSize: 16.sp,
                radius: 12.r,
                verticalPadding: 12.h,
                hasShadow: true,
                shadowColor: theme.primaryColor,
                shadowOpacity: 0.3,
                shadowBlurRadius: 4,
                shadowSpreadRadius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension SizedBoxExtension on double {
  SizedBox get verticalSpace => SizedBox(height: this);
}

extension SizedBoxWidthExtension on double {
  SizedBox get horizontalSpace => SizedBox(width: this);
}
