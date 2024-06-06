import 'package:flutter/material.dart';
import 'main.dart';  // Correct import to return to the main app
import 'registration_page.dart'; // Correct import for the registration page

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF153866),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),  // Adds vertical spacing
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 600,  // Set a fixed width for the container
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 251, 251, 1),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        color: Color(0x1917171C),
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,  // Use min to confine the column size to its children size
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Image.asset('assets/SPINELINK_Vec.png', height: 150),  // Increased logo height
                      const SizedBox(height: 24),
                      const Text(
                        'Inicio de Sesión',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Ingresa tus datos.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 24),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(
                              doctorName: 'Guadalupe Espinosa López',
                              cedula: 'ABCD800724MDFRRR00',
                              hospital: 'Centro Médico de Occidente'
                            )
                          )
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF153866), // Background color
                          foregroundColor: Colors.white, // Text color
                          minimumSize: const Size(double.infinity, 44), // Button size
                          padding: const EdgeInsets.symmetric(horizontal: 0), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Border radius
                            side: const BorderSide(color: Colors.transparent), // Border color
                          ),
                          elevation: 2, // Shadow elevation
                        ),
                        child: const Text('Iniciar sesión', style: TextStyle(fontFamily: 'Inter', letterSpacing: 0)),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())),
                          child: const Text(
                            'Recuperar contraseña',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF153866),
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // New Row for registration and account creation
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())),
                        child: const Text(
                          '¿Aún no estás registrado?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF153866),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())),
                        child: const Text(
                          'Crea una cuenta nueva.',
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
    );
  }
}
