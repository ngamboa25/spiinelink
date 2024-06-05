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
    patientData = List.generate(4, (index) {
      String fullGuid = faker.guid.guid();
      String limitedGuid = fullGuid.substring(0, 10); // Limit ID to 10 characters
      return {
        'name': faker.person.name(),
        'id': limitedGuid,
      };
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
        color: Colors.lightBlue[50], // Page background color
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(60, 60, 60, 60),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF193A61),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/doc_icon.png', // Your image path
                        fit: BoxFit.cover,
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
              child: buildInfoBox('${widget.cedula}'),
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
                  backgroundColor: const Color(0xFFFFCDD2),
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
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF193A61),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Text(
                          'Lista de Pacientes',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(120, 0, 0, 0),
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Color(0xFF193A61),
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextButton(
                                  onPressed: () {
                                    _showAddPatientDialog(context);
                                  },
                                  child: const Text(
                                    'Añadir',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF193A61),
                                      fontSize: 20,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF193A61),
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Buscar',
                                    border: InputBorder.none,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                itemCount: patientData.length,
                itemBuilder: (_, index) {
                  final patient = patientData[index];
                  if (patient['name']!.toLowerCase().contains(searchQuery)) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 9),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDEDFF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 0, 20),
                              child: Text(
                                patient['name']!,
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF193A61),
                                  fontSize: 25,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.search, color: Color(0xFF193A61)),
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
                                  Text(
                                    patient['id']!,
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF193A61),
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
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
                  return Container();
                },
              ),
            ),
          ],
        ),
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
