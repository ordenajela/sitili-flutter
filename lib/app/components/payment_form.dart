import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/modules/cart/controllers/payment_controller.dart';
import 'package:ecommerce_app/app/modules/orders/views/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/utils/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              Row(
                children: [
                  Column(
                    children: [
                      const ScreenTitle(
                        title: 'Tarjeta',
                        dividerEndIndent: 280,
                      ),
                    ],
                  ),
                  Spacer(),
                  RoundedButton(
                    onPressed: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      Constants.backArrowIcon,
                      fit: BoxFit.none,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              CreditCardWidget(
                cardNumber: cardNumberController.text,
                expiryDate: expiryDateController.text,
                cardHolderName: cardHolderNameController.text,
                cvvCode: cvvCodeController.text,
                showBackView: false,
                onCreditCardWidgetChange: (CreditCardBrand brand) {
                  // Callback para cualquier cambio en la marca de la tarjeta de crédito
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
                  // Callback para ejecutar al finalizar el llenado de los datos de la tarjeta
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
                  // Obtén una referencia al PaymentController
                  final PaymentController paymentController = Get.find();

                  // Llama al método makePayment con los datos del formulario
                  paymentController.makePayment(
                    cardNumber: cardNumberController.text,
                    expiryDate: expiryDateController.text,
                    cvvCode: cvvCodeController.text,
                  );
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
              CustomButton(
                text: 'Pagar',
                onPressed: () {
                  // Obtén una referencia al PaymentController
                  final PaymentController paymentController = Get.find();

                  paymentController.makeOrderSaleCar();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersView()),
                  );
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
    // Limpiar controladores al desechar el widget
    cardNumberController.dispose();
    expiryDateController.dispose();
    cardHolderNameController.dispose();
    cvvCodeController.dispose();
    super.dispose();
  }
}
