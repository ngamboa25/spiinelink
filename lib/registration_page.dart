import 'package:flutter/material.dart';
import 'main.dart';

class RegistrationPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cedulaController = TextEditingController();
  final hospitalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nombre Completo')),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Correo Electrónico')),
              TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
              TextField(controller: confirmPasswordController, decoration: const InputDecoration(labelText: 'Confirmar Contraseña'), obscureText: true),
              TextField(controller: cedulaController, decoration: const InputDecoration(labelText: 'Cédula')),
              TextField(controller: hospitalController, decoration: const InputDecoration(labelText: 'Hospital')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _registerAndNavigate(context),
                child: const Text('Registrarse')
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerAndNavigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(
          doctorName: nameController.text,
          cedula: cedulaController.text,
          hospital: hospitalController.text,
        )
      ),
    );
  }
}
