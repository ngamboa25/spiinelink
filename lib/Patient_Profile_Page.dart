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
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blue[300],
      ),
      body: Row(
        children: [
          buildPatientDetails(),
          Expanded(
            child: buildMedicalInformation(),
          ),
        ],
      ),
    );
  }

  Widget buildPatientDetails() {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(10),
      color: Colors.lightBlue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/patient_icon.png')),
          const SizedBox(height: 20),
          Text('Nombre: $name', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('ID: $patientId', style: const TextStyle(fontSize: 16)),
          Text('Hospital: $hospitalName', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => navigateToEditProfile(context), child: const Text('Editar Perfil')),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CalculadoraPag()));
          }, child: const Text('Calculadora')),
        ],
      ),
    );
  }

  Widget buildMedicalInformation() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Historial Clínico', clinicalHistory, (value) => clinicalHistory = value),
              const SizedBox(height: 10),
              buildTextField('Motivo de Consulta', consultationReason, (value) => consultationReason = value),
              const SizedBox(height: 10),
              buildTextField('Diagnóstico', diagnosis, (value) => diagnosis = value),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => navigateToImageAnalysis(context),
                child: const Text('Análisis de Imágenes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value, Function(String) onChange) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: onChange,
      maxLines: 3,
    );
  }

  void navigateToEditProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientProfileEdit(
          name: name, patientId: patientId, hospitalName: hospitalName,
          clinicalHistory: clinicalHistory, consultationReason: consultationReason, diagnosis: diagnosis
        )
      )
    );

    if (result != null) {
      setState(() {
        name = result['name'];
        patientId = result['patientId'];
        hospitalName = result['hospitalName'];
        clinicalHistory = result['clinicalHistory'];
        consultationReason = result['consultationReason'];
        diagnosis = result['diagnosis'];
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