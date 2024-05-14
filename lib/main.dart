import 'package:flutter/material.dart';
import 'login_page.dart'; // Ensure you have a login_page.dart in your lib folder with a LoginPage widget

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
          backgroundColor: Colors.blue[300], // Logo color
          title: Image.asset('assets/logo.png', height: 50),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3, // Slightly reduced flex to better fit web
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 40, // Reduced size for aesthetics
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.blue[100],
                      child: const Text('Dr. Seungmin', style: TextStyle(fontSize: 16)),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[300]!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.blue[100],
                      child: const Text('Cédula', style: TextStyle(fontSize: 16)),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[300]!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.blue[100],
                      child: const Text('Hospital', style: TextStyle(fontSize: 16)),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[300]!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.black,
                      ),
                      icon: const Icon(Icons.settings),
                      label: const Text('Editar Perfil'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Navigating to the LoginPage when "Cerrar Sesión" is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}
