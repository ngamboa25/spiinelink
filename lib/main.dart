import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'login_page.dart'; // Ensure this file is correctly set up and exists.
import 'user_profile_page.dart'; // Import the UserProfilePage.
import 'patient_profile_page.dart'; // Ensure this page exists and is set up correctly.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String doctorName = 'Nombre de Personal de Salud'; // Default value
  String cedula = 'Cédula';   // Default value
  String hospital = 'Nombre de la institución'; // Default value
  List<Map<String, String>> patientData = []; // Will store patient data
  String searchQuery = ''; // Declare searchQuery variable

  @override
  void initState() {
    super.initState();
    Faker faker = Faker();
    patientData = List.generate(9, (index) => {
      'name': faker.person.name(),
      'id': faker.guid.guid(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Image.asset('assets/logo.png', height: 50),
      ),
      body: Row(
        children: [
          buildSidePanel(context),
          buildPatientListSection(context),
        ],
      ),
    );
  }

  Widget buildSidePanel(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 60),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildInfoBox(doctorName, Colors.blue[100]!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildInfoBox(cedula, Colors.blue[100]!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildInfoBox(hospital, Colors.blue[100]!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserProfilePage()),
                  );
                  if (result != null) {
                    setState(() {
                      doctorName = result['userName'];
                      cedula = result['userCedula'];
                      hospital = result['hospitalName'];
                    });
                  }
                },
                icon: const Icon(Icons.settings),
                label: const Text('Editar Perfil', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            buildTextButton('Ayuda'),
            buildTextButton('Términos y Condiciones'),
            buildTextButton('Aviso de Privacidad'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Cerrar Sesión', style: TextStyle(fontSize: 16, color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPatientListSection(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {}, // Add functionality for "Añadir"
                  child: const Text('Añadir'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlue[100],
                    backgroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {}, // Add functionality for "Editar"
                  child: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlue[100],
                    backgroundColor: Colors.black,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: patientData.length,
              itemBuilder: (_, index) {
                final patient = patientData[index];
                if (patient['name']!.toLowerCase().contains(searchQuery)) {
                  return ListTile(
                    title: Text(patient['name']!),
                    subtitle: Text('ID: ${patient['id']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientProfilePage(
                              name: patient['name']!,
                              patientId: patient['id']!,
                              hospitalName: hospital,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container(); // Return empty container for non-matching items
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoBox(String text, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.blue[300]!, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
    );
  }

  Widget buildTextButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        onPressed: () {},
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
