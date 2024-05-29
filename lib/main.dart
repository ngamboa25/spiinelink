import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'login_page.dart';
import 'patient_profile_page.dart';
import 'user_profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String doctorName;
  final String cedula;
  final String hospital;

  const MyApp({Key? key, this.doctorName = 'Guadalupe Espinosa López', this.cedula = 'ABCD800724MDFRRR00', this.hospital = 'Centro Médico de Occidente'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(doctorName: doctorName, cedula: cedula, hospital: hospital),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String doctorName;
  final String cedula;
  final String hospital;

  const HomeScreen({Key? key, required this.doctorName, required this.cedula, required this.hospital}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> patientData = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    Faker faker = Faker();
    patientData = List.generate(4, (index) => {
      'name': faker.person.name(),
      'id': faker.guid.guid(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Image.asset('assets/SPINELINK_Vec.png', height: 50),
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
              child: buildInfoBox(widget.doctorName, Colors.blue[100]!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildInfoBox(widget.cedula, Colors.blue[100]!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildInfoBox(widget.hospital, Colors.blue[100]!),
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
                    setState(() {});
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
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
                  onPressed: () {
                    _showAddPatientDialog(context);
                  },
                  child: const Text('Añadir'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlue[100],
                    backgroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlue[100],
                    backgroundColor: Colors.black,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
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
                              hospitalName: widget.hospital,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPatientDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Patient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                var newName = nameController.text;
                var newId = idController.text;
                setState(() {
                  patientData.add({
                    'name': newName,
                    'id': newId,
                  });
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientProfilePage(
                        name: newName,
                        patientId: newId,
                        hospitalName: widget.hospital,
                      ),
                    ),
                  );
                });
              },
              child: const Icon(Icons.check, color: Colors.green),
            )
          ],
        );
      },
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
