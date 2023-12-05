import 'package:flutter/material.dart';

class ProfileAdminView extends StatelessWidget {
  const ProfileAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://example.com/admin_profile_image.jpg', // Coloca la URL de la imagen del administrador
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre del Administrador',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Text(
              'Correo Electrónico: admin@example.com', // Coloca el correo electrónico del administrador
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
