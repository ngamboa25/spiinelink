import 'package:flutter/material.dart';

class ImageAnalysisPage extends StatefulWidget {
  final String imageNotes1;
  final String imageNotes2;

  const ImageAnalysisPage({Key? key, required this.imageNotes1, required this.imageNotes2}) : super(key: key);

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
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/xray1.png', height: 200),
                      TextField(
                        controller: notesController1,
                        decoration: const InputDecoration(
                          labelText: 'Notas sobre la primera imagen',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/xray2.png', height: 200),
                      TextField(
                        controller: notesController2,
                        decoration: const InputDecoration(
                          labelText: 'Notas sobre la segunda imagen',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                saveNotesAndExit();
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  void saveNotesAndExit() {
    Navigator.pop(context, {'imageNotes1': notesController1.text, 'imageNotes2': notesController2.text});
    showSuccessBanner(context);
  }

  @override
  void dispose() {
    notesController1.dispose();
    notesController2.dispose();
    super.dispose();
  }

  void showSuccessBanner(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Cambios guardados exitosamente'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
