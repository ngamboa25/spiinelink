import 'package:flutter/material.dart';

class PatientProfilePage extends StatelessWidget {
  final String name;

  // Constructor requires a patient name
  const PatientProfilePage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name), // Display the patient's name in the AppBar
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Patient Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Name: $name", style: const TextStyle(fontSize: 18)), // Display the patient's name
            const SizedBox(height: 10),
            // Add more patient details here
            const Text("Details:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            const Text("This section can contain more detailed information about the patient, such as medical history, current medications, and other relevant health data.", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
