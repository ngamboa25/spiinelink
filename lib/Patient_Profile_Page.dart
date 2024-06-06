import 'package:flutter/material.dart';
import 'patient_profile_edit.dart';
import 'calculadora_pag.dart';
import 'image_analysis_page.dart';

class PatientProfilePage extends StatefulWidget {
  final String name;
  final String patientId;
  final String hospitalName;

  const PatientProfilePage({Key? key, required this.name, required this.patientId, required this.hospitalName}) : super(key: key);

  @override
  PatientProfilePageState createState() => PatientProfilePageState();
}

class PatientProfilePageState extends State<PatientProfilePage> {
  late String name;
  late String patientId;
  late String hospitalName;
  String clinicalHistory = '';
  String consultationReason = '';
  String diagnosis = '';
  String imageNotes1 = '';  // Holds the notes for the first image.
  String imageNotes2 = '';  // Holds the notes for the second image.

  @override
  void initState() {
    super.initState();
    name = widget.name;
    patientId = widget.patientId;
    hospitalName = widget.hospitalName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFFDDEDFF),
        centerTitle: true,
        elevation: 0,
      ),
      body: buildProfileWidget(context),
    );
  }

  Widget buildProfileWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(60),
              child: Container(
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
                    'assets/image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              'Nombre: $name',
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            buildInfoBox('ID: $patientId'),
            buildInfoBox('Hospital: $hospitalName'),
            buildTextField('Historial Clínico', clinicalHistory, (value) => setState(() => clinicalHistory = value)),
            buildTextField('Motivo de Consulta', consultationReason, (value) => setState(() => consultationReason = value)),
            buildTextField('Diagnóstico', diagnosis, (value) => setState(() => diagnosis = value)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToImageAnalysis(context),
              child: const Text('Análisis de Imágenes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDDEDFF),
                foregroundColor: const Color(0xFF193A61),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFF193A61), width: 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CalculadoraPag()));
              },
              child: const Text('Calculadora'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDDEDFF),
                foregroundColor: const Color(0xFF193A61),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFF193A61), width: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String initialValue, Function(String) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChange,
      ),
    );
  }

  Widget buildInfoBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF193A61), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }

  void navigateToEditProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientProfileEdit(
          name: name, patientId: patientId, hospitalName: hospitalName, clinicalHistory: clinicalHistory, consultationReason: consultationReason, diagnosis: diagnosis
        )
      )
    );

    if (result != null) {
      setState(() {
        name = result['name'];
        patientId = result['patientId'];
        hospitalName = result['hospitalName'];
      });
    }
  }

  void navigateToImageAnalysis(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageAnalysisPage(imageNotes1: imageNotes1, imageNotes2: imageNotes2)
      )
    );

    if (result != null) {
      setState(() {
        imageNotes1 = result['imageNotes1'] ?? imageNotes1;
        imageNotes2 = result['imageNotes2'] ?? imageNotes2;
      });
    }
  }
}
