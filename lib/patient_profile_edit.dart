import 'package:flutter/material.dart';

class PatientProfileEdit extends StatefulWidget {
  final String name;
  final String patientId;
  final String hospitalName;
  final String clinicalHistory;
  final String consultationReason;
  final String diagnosis;

  const PatientProfileEdit({
    super.key,
    required this.name,
    required this.patientId,
    required this.hospitalName,
    required this.clinicalHistory,
    required this.consultationReason,
    required this.diagnosis,
  });

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
      backgroundColor: Colors.white, // Background color
      appBar: AppBar(
        title: const Text('Editar Perfil del Paciente'),
        backgroundColor: const Color(0xFF153866), // Adjusting the AppBar color to match
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              buildTextField(nameController, 'Nombre'),
              buildTextField(patientIdController, 'ID'),
              buildTextField(hospitalNameController, 'Hospital'),
              buildTextField(clinicalHistoryController, 'Historial Clínico'),
              buildTextField(consultationReasonController, 'Motivo de Consulta'),
              buildTextField(diagnosisController, 'Diagnóstico'),
              const SizedBox(height: 30), // Added more spacing before the button
              ElevatedButton(
                onPressed: _saveAndExit,
                child: const Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF153866), // Button color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.edit, color: Colors.grey), // Add an edit icon to each field
        ),
      ),
    );
  }

  void _saveAndExit() {
    if (true) { // Simplified for example, check your conditions
      Navigator.pop(context, {
        'name': nameController.text,
        'patientId': patientIdController.text,
        'hospitalName': hospitalNameController.text,
        'clinicalHistory': clinicalHistoryController.text,
        'consultationReason': consultationReasonController.text,
        'diagnosis': diagnosisController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!'))
      );
    }
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
