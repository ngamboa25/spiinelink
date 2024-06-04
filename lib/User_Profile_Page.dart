import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // Set the background color of the whole page
      appBar: AppBar(
        backgroundColor: const Color(0xFF153866),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: 180, // Narrower width for "Editar Perfil"
                height: 44, // Standard height for buttons
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF153866),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Editar Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 251, 251, 1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column for specific fields
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center, // Center the icon
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                              child: Icon(Icons.person, size: 60, color: Colors.grey),
                            ),
                            const SizedBox(height: 20),
                            buildTextField(_userNameController, "Nombre del usuario"),
                            buildTextField(_cedulaController, "Cédula"),
                            buildTextField(_hospitalNameController, "Nombre del hospital"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20), // Adding space between columns
                      // Right column for other fields
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildTextField(_emailController, "Correo electrónico"),
                            buildTextField(_confirmEmailController, "Confirmar correo electrónico"),
                            buildTextField(_passwordController, "Contraseña", isPassword: true),
                            buildTextField(_confirmPasswordController, "Confirmar contraseña", isPassword: true),
                            buildTextField(_phoneNumberController, "Número telefónico"),
                            buildTextField(_confirmPhoneNumberController, "Confirmar número telefónico"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Guardar cambios'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF153866),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(180, 44), // Narrower and standard height for buttons
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.edit, color: Colors.grey),
        ),
        obscureText: isPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingrese $label';
          }
          return null;
        },
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'userName': _userNameController.text,
        'userCedula': _cedulaController.text,
        'hospitalName': _hospitalNameController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!'))
      );
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _cedulaController.dispose();
    _hospitalNameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _confirmPhoneNumberController.dispose();
    super.dispose();
  }
}
