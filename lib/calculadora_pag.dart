import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Tornillos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculadoraPag(),
    );
  }
}

class CalculadoraPag extends StatefulWidget {
  const CalculadoraPag({super.key});

  @override
  CalculadoraPagState createState() => CalculadoraPagState();
}

class CalculadoraPagState extends State<CalculadoraPag> {
  final TextEditingController _diametroCanulaController = TextEditingController();
  final TextEditingController _diametroFenestracionesController = TextEditingController();
  final TextEditingController _distanciaFenestracionesController = TextEditingController();
  final TextEditingController _cantidadFenestracionesController = TextEditingController();
  String? selectedScrew;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDEDFF),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Calculadora'),
              ),
              const SizedBox(height: 20),
              _buildTable(),
              const SizedBox(height: 20),
              _buildDropDown(),
              _buildScrewDetailRows(),
              const SizedBox(height: 20),
              _buildCalculateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Table _buildTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FixedColumnWidth(40), // Checkbox column width
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            for (var title in ['Tamaño Vertebral', 'Densidad Ósea', 'Porosidad', 'Permeabilidad', ''])
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ),
          ],
        ),
        for (var vertebra in ['T12', 'L1', 'L2', 'L3', 'L4', 'L5'])
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(vertebra, textAlign: TextAlign.center),
              ),
              for (var _ in [1, 2, 3]) // Three input fields per vertebra
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 70, // Further reduced width for the input fields
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
              ),
            ],
          ),
      ],
    );
  }

  DropdownButtonFormField<String> _buildDropDown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      isExpanded: true,
      hint: const Text('Elegir Modelo de Tornillo'),
      value: selectedScrew,
      onChanged: (value) {
        setState(() {
          selectedScrew = value;
          _updateScrewDetails(value);
        });
      },
      items: const [
        DropdownMenuItem(value: 'Spinelink', child: Text('Tornillo Spinelink')),
        DropdownMenuItem(value: 'AddNew', child: Text('Añadir modelo nuevo')),
      ],
    );
  }

  Widget _buildScrewDetailRows() {
    List<List<dynamic>> details = [
      ['Diámetro de Cánula', _diametroCanulaController],
      ['Diámetro de Fenestraciones', _diametroFenestracionesController],
      ['Distancia entre Fenestraciones', _distanciaFenestracionesController],
      ['Cantidad de Fenestraciones', _cantidadFenestracionesController]
    ];

    return Column(
      children: details.map((detail) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(detail[0]),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: detail[1],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  ElevatedButton _buildCalculateButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFDDEDFF),
        foregroundColor: Color(0xFF193A61),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      child: const Text('CALCULAR'),
    );
  }

  void _updateScrewDetails(String? model) {
    if (model == 'Spinelink') {
      _diametroCanulaController.text = '1.6 mm';
      _diametroFenestracionesController.text = '1.6 mm';
      _distanciaFenestracionesController.text = '3.3 mm';
      _cantidadFenestracionesController.text = '6';
    } else {
      _diametroCanulaController.clear();
      _diametroFenestracionesController.clear();
      _distanciaFenestracionesController.clear();
      _cantidadFenestracionesController.clear();
    }
  }
}
