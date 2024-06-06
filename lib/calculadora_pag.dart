import 'package:flutter/material.dart';

class CalculadoraPag extends StatefulWidget {
  @override
  CalculadoraPagState createState() => CalculadoraPagState();
}

class CalculadoraPagState extends State<CalculadoraPag> {
  final TextEditingController _diametroTornilloController = TextEditingController();
  final TextEditingController _diametroCanulaController = TextEditingController();
  final TextEditingController _diametroFenestracionesController = TextEditingController();
  final TextEditingController _numeroFenestracionesController = TextEditingController();
  String? selectedScrew;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text('Tamaño vertebral', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              for (var vertebra in ['T12', 'L1', 'L2', 'L3', 'L4', 'L5'])
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(labelText: '$vertebra tamaño'))),
                    const SizedBox(width: 10),
                    Expanded(child: TextField(decoration: InputDecoration(labelText: '$vertebra densidad'))),
                  ],
                ),
              const SizedBox(height: 20),
              const Text('Elegir modelo de tornillo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedScrew,
                onChanged: (value) {
                  setState(() {
                    selectedScrew = value;
                    _updateScrewDetails(value);
                  });
                },
                items: const [
                   DropdownMenuItem(value: 'Spinelink', child: Text('Tornillo Spinelink')),
                  // Añadir más modelos según sea necesario
                ],
              ),
              TextField(controller: _diametroTornilloController, decoration: const InputDecoration(labelText: 'Diámetro de tornillo')),
              TextField(controller: _diametroCanulaController, decoration: const InputDecoration(labelText: 'Diámetro de cánula')),
              TextField(controller: _diametroFenestracionesController, decoration: const InputDecoration(labelText: 'Diámetro de fenestraciones')),
              TextField(controller: _numeroFenestracionesController, decoration: const InputDecoration(labelText: 'Número de fenestraciones')),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'MMA'))),
                  SizedBox(width: 10),
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'PMMA'))),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para calcular
                },
                child: const Text('Calcular'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateScrewDetails(String? model) {
    // Supongamos que estos son los detalles para el modelo "Spinelink"
    if (model == 'Spinelink') {
      _diametroTornilloController.text = '5 mm';
      _diametroCanulaController.text = '3 mm';
      _diametroFenestracionesController.text = '1 mm';
      _numeroFenestracionesController.text = '4';
    } else {
      // Limpiar los campos si se selecciona otro modelo o ninguno
      _diametroTornilloController.clear();
      _diametroCanulaController.clear();
      _diametroFenestracionesController.clear();
      _numeroFenestracionesController.clear();
    }
  }
}
