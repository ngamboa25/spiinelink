import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'login_page.dart'; // Ensure this file is set up correctly and exists.
import 'User_Profile_Page.dart'; // Import the UserProfilePage.
import 'Patient_Profile_Page.dart'; // Make sure this page exists and is correctly set up.

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
  String doctorName = 'Dr. Seungmin'; // Default value
  String cedula = 'Cédula Initial';   // Default value
  String hospital = 'Hospital Initial'; // Default value
  List<String> patientNames = [];

  @override
  void initState() {
    super.initState();
    Faker faker = Faker();
    patientNames = List.generate(9, (_) => faker.person.name());
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
          Expanded(
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
          ),
          buildPatientListSection(),
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
                const Expanded(
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
            child: ListView.builder(
              itemCount: patientNames.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(patientNames[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientProfilePage(name: patientNames[index])),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
