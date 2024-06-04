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

  const MyApp({
    Key? key,
    this.doctorName = 'Guadalupe Espinosa López',
    this.cedula = 'ABCD800724MDFRRR00',
    this.hospital = 'Centro Médico de Occidente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(
        doctorName: doctorName,
        cedula: cedula,
        hospital: hospital,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String doctorName;
  final String cedula;
  final String hospital;

  const HomeScreen({
    Key? key,
    required this.doctorName,
    required this.cedula,
    required this.hospital,
  }) : super(key: key);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDEDFF),
        title: Image.asset('assets/SPINELINK_Vec.png', height: 50),
      ),
      body: Row(
        children: [
          buildProfileWidget(context),
          buildPatientListSection(context),
        ],
      ),
    );
  }

  Widget buildProfileWidget(BuildContext context) {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white, // Page background color
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF193A61),
                          width: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.doctorName,
                      style: const TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 30,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                child: buildInfoBox(' ${widget.cedula}'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: buildInfoBox('${widget.hospital}'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfilePage(),
                      ),
                    );
                    if (result != null) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text('Editar Perfil', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDDEDFF),
                    foregroundColor: const Color(0xFF193A61),
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color(0xFF193A61),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.exit_to_app, color: Colors.red),
                  label: const Text('Cerrar Sesión', style: TextStyle(fontSize: 16, color: Colors.red)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCDD2), // Light red background
                    foregroundColor: Colors.red,
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  Widget buildInfoBox(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: const Color(0xFFDDEDFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF193A61),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Readex Pro',
            color: Color(0xFF193A61),
            fontSize: 20,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  Widget buildTextButton(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        onPressed: () {},
        child: Text(text, style: TextStyle(fontSize: 16, color: color)),
      ),
    );
  }
}
