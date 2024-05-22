import 'package:flutter/material.dart';

class ImageAnalysisPage extends StatefulWidget {
  final String imageNotes;  // Ensure this parameter is accepted

  const ImageAnalysisPage({Key? key, required this.imageNotes}) : super(key: key);

  @override
  ImageAnalysisPageState createState() => ImageAnalysisPageState();
}

class ImageAnalysisPageState extends State<ImageAnalysisPage> {
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(text: widget.imageNotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análisis de Imágenes'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          Image.asset('assets/xray_image.png'), // Example image, replace with actual asset path
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notas sobre las imágenes',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {'imageNotes': notesController.text});
            },
            child: const Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
