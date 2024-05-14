import 'package:flutter/material.dart';
import 'login_page.dart'; // Ensure this file is set up correctly and exists.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300], // Assumed logo color
          title: Image.asset('assets/logo.png', height: 50), // Ensure your asset path is correct
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 60),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0), // 1 cm vertical separation approx
                      child: buildInfoBox('Dr. Seungmin', Colors.blue[100]!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: buildInfoBox('Cédula', Colors.blue[100]!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: buildInfoBox('Hospital', Colors.blue[100]!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                          foregroundColor: Colors.black,
                        ),
                        icon: Icon(Icons.settings),
                        label: Text('Editar Perfil', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    buildTextButton('Ayuda'),
                    buildTextButton('Términos y Condiciones'),
                    buildTextButton('Aviso de Privacidad'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        ),
                        child: Text('Cerrar Sesión', style: TextStyle(fontSize: 16, color: Colors.red)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildPatientListSection(),
          ],
        ),
      ),
    );
  }

  Widget buildInfoBox(String text, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.blue[300]!, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
    );
  }

  Widget buildTextButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        onPressed: () {},
        child: Text(text, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget buildPatientListSection() {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Añadir'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Editar'),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Buscar',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 8,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) => ListTile(
                title: Text('Paciente ${index + 1}'),
                trailing: const Icon(Icons.more_vert),
              ),
            ),
          ),
        ],
      ),
    );
  }
}