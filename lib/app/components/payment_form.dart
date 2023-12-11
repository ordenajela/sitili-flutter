import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/components/custom_button_pay.dart';
import 'package:ecommerce_app/app/modules/base/views/base_view.dart';
import 'package:ecommerce_app/app/modules/cart/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:get/get.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key? key}) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPaymentButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Método de pago',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
             
              CreditCardWidget(
                cardNumber: cardNumberController.text,
                expiryDate: expiryDateController.text,
                cardHolderName: cardHolderNameController.text,
                cvvCode: cvvCodeController.text,
                showBackView: false,
                onCreditCardWidgetChange: (CreditCardBrand brand) {
                 
                },
              ),
              20.verticalSpace,
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumberController.text,
                expiryDate: expiryDateController.text,
                cardHolderName: cardHolderNameController.text,
                cvvCode: cvvCodeController.text,
                cardNumberValidator: (String? cardNumber) {},
                expiryDateValidator: (String? expiryDate) {},
                cvvValidator: (String? cvv) {},
                cardHolderValidator: (String? cardHolderName) {},
                onCreditCardModelChange: onCreditCardModelChange,
                obscureCvv: true,
                obscureNumber: false,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                enableCvv: true,
                cvvValidationMessage: 'Ingrese un CVV válido',
                dateValidationMessage: 'Ingrese una fecha válida',
                numberValidationMessage: 'Ingrese un número válido',
                onFormComplete: () {
                 
                },
                autovalidateMode: AutovalidateMode.always,
                disableCardNumberAutoFillHints: false,
                inputConfiguration: const InputConfiguration(
                  cardNumberDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Número de Tarjeta',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fecha de Expiración',
                    hintText: 'MM/AA',
                  ),
                  cvvCodeDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Titular de la Tarjeta',
                  ),
                  cardNumberTextStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  cardHolderTextStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  expiryDateTextStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  cvvCodeTextStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Enviar',
                onPressed: () {
      
                  final PaymentController paymentController = Get.find();

                  paymentController.makePayment(
                    cardNumber: cardNumberController.text,
                    expiryDate: expiryDateController.text,
                    cvvCode: cvvCodeController.text,
                  );

                  setState(() {
                    isPaymentButtonEnabled = true;
                  });
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
              CustomButtonPay(
                text: 'Pagar',
                onPressed: isPaymentButtonEnabled
                    ? () {
                     
                        final PaymentController paymentController = Get.find();

                        paymentController.makeOrderSaleCar();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BaseView()),
                        );
                       
                      }
                    : null,
                fontSize: 16.sp,
                radius: 12.r,
                verticalPadding: 12.h,
                hasShadow: true,
                shadowColor: theme.primaryColor,
                shadowOpacity: 0.3,
                shadowBlurRadius: 4,
                shadowSpreadRadius: 0,
                disabled: !isPaymentButtonEnabled,
                disabledColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel data) {
    setState(() {
      cardNumberController.text = data.cardNumber ?? '';
      expiryDateController.text = data.expiryDate ?? '';
      cardHolderNameController.text = data.cardHolderName ?? '';
      cvvCodeController.text = data.cvvCode ?? '';
    });
  }

  @override
  void dispose() {
   
    cardNumberController.dispose();
    expiryDateController.dispose();
    cardHolderNameController.dispose();
    cvvCodeController.dispose();
    super.dispose();
  }
}
