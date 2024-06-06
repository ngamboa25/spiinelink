import 'package:flutter/material.dart';
import 'main.dart';  // Assuming this is where MyApp is defined
import 'login_page.dart';  // Ensure this is the correct path to your LoginPage

class RegistrationPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cedulaController = TextEditingController();
  final hospitalController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(  // Use Row to create a side-by-side layout
        children: [
          // Registration Form Column
          Expanded(
            flex: 3,  // Adjusted to give more space to the form
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/SPINELINK_Vec.png',
                        width: 150,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Crear una cuenta', style: Theme.of(context).textTheme.headlineLarge),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                      child: Text(
                        'Comencemos rellenando el formulario a continuación.',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    _buildTextField(context, 'Nombre Completo', nameController),
                    _buildTextField(context, 'Correo Electrónico', emailController),
                    _buildPasswordField(context, 'Contraseña', passwordController),
                    _buildPasswordField(context, 'Confirmar Contraseña', confirmPasswordController),
                    _buildTextField(context, 'Cédula', cedulaController),
                    _buildTextField(context, 'Hospital', hospitalController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _registerAndNavigate(context),
                      child: const Text('Registrarse'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF153866),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        textStyle: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Ya eres un usuario registrado? ',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF153866),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            ),
                            child: const Text(
                              'Inicia sesión aquí',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Decorative Gradient Container Column
          Expanded(
            flex: 2,  // Smaller flex value to reduce the size of the gradient box
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 100,  // Explicit width
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF153866), Theme.of(context).colorScheme.secondary],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromRGBO(245, 251, 251, 1),
        ),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context, String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromRGBO(245, 251, 251, 1),
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
