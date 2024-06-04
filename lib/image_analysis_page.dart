import 'package:flutter/material.dart';

class ImageAnalysisPage extends StatefulWidget {
  final String imageNotes1;
  final String imageNotes2;

  const ImageAnalysisPage({super.key, required this.imageNotes1, required this.imageNotes2});

  @override
  ImageAnalysisPageState createState() => ImageAnalysisPageState();
}

class ImageAnalysisPageState extends State<ImageAnalysisPage> {
  late TextEditingController notesController1;
  late TextEditingController notesController2;

  @override
  void initState() {
    super.initState();
    notesController1 = TextEditingController(text: widget.imageNotes1);
    notesController2 = TextEditingController(text: widget.imageNotes2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análisis de Imágenes'),
        backgroundColor: const Color(0xFFDDEDFF), // Set the specific color you want
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/xray1.png', height: 200),  // Adjust image asset as needed
                      TextField(
                        controller: notesController1,
                        decoration: const InputDecoration(
                          hintText: 'Añadir un poco de texto',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/xray2.png', height: 200),  // Adjust image asset as needed
                      TextField(
                        controller: notesController2,
                        decoration: const InputDecoration(
                          hintText: 'Añadir un poco de texto',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNotesAndExit,
              child: const Text('Guardar Cambios'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF153866), // Use a color that fits your app theme
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Set the background color of the page to white
    );
  }

  void saveNotesAndExit() {
    Navigator.pop(context, {'imageNotes1': notesController1.text, 'imageNotes2': notesController2.text});
    showSuccessBanner(context);
  }

  void showSuccessBanner(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Cambios guardados exitosamente'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    notesController1.dispose();
    notesController2.dispose();
    super.dispose();
  }
}
