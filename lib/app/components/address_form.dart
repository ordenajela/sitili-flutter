import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/components/payment_form.dart';
import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/modules/cart/controllers/address_controller.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

TextEditingController _countryController = TextEditingController();
TextEditingController _stateController = TextEditingController();
TextEditingController _cityController = TextEditingController();
TextEditingController _postalCodeController = TextEditingController();
TextEditingController _mainAddressController = TextEditingController();
TextEditingController _streetAddress1Controller = TextEditingController();
TextEditingController _streetAddress2Controller = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
AddressController _addressController = AddressController();

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Dirección',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Agrega la lógica para retroceder aquí
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
            children: <Widget>[
              30.verticalSpace,
              Row(
                children: [
                  const ScreenTitle(
                    title: 'Dirección',
                    dividerEndIndent: 280,
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
              Text(
                'Ingrese su dirección:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'País'),
              ),
              TextField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'Estado'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ciudad'),
              ),
              TextField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'Código Postal'),
              ),
              TextField(
                controller: _mainAddressController,
                decoration: InputDecoration(labelText: 'Calle Principal'),
              ),
              TextField(
                controller: _streetAddress1Controller,
                decoration: InputDecoration(labelText: 'Calle 1 (opcional)'),
              ),
              TextField(
                controller: _streetAddress2Controller,
                decoration: InputDecoration(labelText: 'Calle 2 (opcional)'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              SizedBox(height: 20.0),
              CustomButton(
                onPressed: () async {
                  // Obteniendo los valores de los TextFields
                  String country = _countryController.text;
                  String state = _stateController.text;
                  String city = _cityController.text;
                  String postalCode = _postalCodeController.text;
                  String mainAddress = _mainAddressController.text;
                  String streetAddress1 = _streetAddress1Controller.text;
                  String streetAddress2 = _streetAddress2Controller.text;
                  String description = _descriptionController.text;

                  // Ejecuta la función para crear o actualizar la dirección
                  await _addressController.createAddress(
                    country: country,
                    state: state,
                    city: city,
                    postalCode: postalCode,
                    mainAddress: mainAddress,
                    streetAddress1: streetAddress1,
                    streetAddress2: streetAddress2,
                    description: description,
                  );

                  // Cerrar el modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentForm()),
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
                text: 'Enviar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
