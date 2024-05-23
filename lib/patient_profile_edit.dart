import 'package:flutter/material.dart';

class PatientProfileEdit extends StatefulWidget {
  final String name;
  final String patientId;
  final String hospitalName;
  final String clinicalHistory;
  final String consultationReason;
  final String diagnosis;

  const PatientProfileEdit({
    Key? key,
    required this.name,
    required this.patientId,
    required this.hospitalName,
    required this.clinicalHistory,
    required this.consultationReason,
    required this.diagnosis,
  }) : super(key: key);

  @override
  PatientProfileEditState createState() => PatientProfileEditState();
}

class PatientProfileEditState extends State<PatientProfileEdit> {
  late TextEditingController nameController;
  late TextEditingController patientIdController;
  late TextEditingController hospitalNameController;
  late TextEditingController clinicalHistoryController;
  late TextEditingController consultationReasonController;
  late TextEditingController diagnosisController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    patientIdController = TextEditingController(text: widget.patientId);
    hospitalNameController = TextEditingController(text: widget.hospitalName);
    clinicalHistoryController = TextEditingController(text: widget.clinicalHistory);
    consultationReasonController = TextEditingController(text: widget.consultationReason);
    diagnosisController = TextEditingController(text: widget.diagnosis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil del Paciente'),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            buildTextField('Nombre', nameController),
            buildTextField('ID', patientIdController),
            buildTextField('Hospital', hospitalNameController),
            buildTextField('Historial Clínico', clinicalHistoryController),
            buildTextField('Motivo de Consulta', consultationReasonController),
            buildTextField('Diagnóstico', diagnosisController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAndExit,
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _saveAndExit() {
    Navigator.pop(context, {
      'name': nameController.text,
      'patientId': patientIdController.text,
      'hospitalName': hospitalNameController.text,
      'clinicalHistory': clinicalHistoryController.text,
      'consultationReason': consultationReasonController.text,
      'diagnosis': diagnosisController.text,
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    patientIdController.dispose();
    hospitalNameController.dispose();
    clinicalHistoryController.dispose();
    consultationReasonController.dispose();
    diagnosisController.dispose();
    super.dispose();
  }
}
