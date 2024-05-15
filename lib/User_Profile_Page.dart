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
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Image.asset('assets/logo.png', height: 50),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            buildTextField(_userNameController, "Nombre del usuario"),
            buildTextField(_cedulaController, "Cédula"),
            buildTextField(_hospitalNameController, "Nombre del hospital"),
            buildTextField(_emailController, "Correo electrónico"),
            buildTextField(_confirmEmailController, "Confirmar correo electrónico"),
            buildTextField(_passwordController, "Contraseña", isPassword: true),
            buildTextField(_confirmPasswordController, "Confirmar contraseña", isPassword: true),
            buildTextField(_phoneNumberController, "Número telefónico"),
            buildTextField(_confirmPhoneNumberController, "Confirmar número telefónico"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile, // Correct linking of the method
              child: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue[300], // Color should be set to `primary` not `foregroundColor`
              ),
            ),
          ],
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
          suffixIcon: isPassword ? null : const Icon(Icons.edit, color: Colors.grey),
        ),
        obscureText: isPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
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
