import 'package:flutter/material.dart';

class ProfileSellerView extends StatelessWidget {
  const ProfileSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Vendedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://example.com/seller_profile_image.jpg', // Coloca la URL de la imagen del vendedor
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre del Vendedor',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Text(
              'Correo Electrónico: seller@example.com', // Coloca el correo electrónico del vendedor
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
