import 'package:flutter/material.dart';
import '../components/atoms/menu_button.dart';
import '../controller/p4_cantidades_controller.dart';
import '../model/p4_cantidades_model.dart';

class P4CantidadesView extends StatefulWidget {
  const P4CantidadesView({super.key});

  @override
  State<P4CantidadesView> createState() => _P4CantidadesViewState();
}

class _P4CantidadesViewState extends State<P4CantidadesView> {
  final P4CantidadesController _controller = P4CantidadesController();
  final TextEditingController _inputController = TextEditingController();

  final List<double> _numeros = [];
  P4CantidadesModel? _resultado;

  void _agregarNumero() {
    FocusScope.of(context).unfocus();
    final texto = _inputController.text.trim();
    if (texto.isEmpty) return;

    final numero = double.tryParse(texto);
    if (numero != null) {
      setState(() {
        _numeros.add(numero);
        _resultado = null; // Reiniciar resultados si agregamos uno nuevo
      });
      _inputController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa un número válido.')),
      );
    }
  }

  void _eliminarNumero(int index) {
    setState(() {
      _numeros.removeAt(index);
      _resultado = null; // Si elimina uno, que calcule de nuevo
    });
  }

  void _analizar() {
    if (_numeros.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un número para analizar.')),
      );
      return;
    }

    setState(() {
      _resultado = _controller.analizarCantidades(_numeros);
    });
  }

  Widget _buildTarjetaResultado(String titulo, int cantidad, Color color) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color.withOpacity(0.5), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
        child: Column(
          children: [
            Text(
              titulo,
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '$cantidad',
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clasificador de Cantidades', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    decoration: const InputDecoration(
                      labelText: 'Ingresa un número',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _agregarNumero(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _agregarNumero,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Añadir', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Área donde aparecen las burbujas
            if (_numeros.isNotEmpty) ...[
              const Text('Números a evaluar:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _numeros.asMap().entries.map((entry) {
                  int idx = entry.key;
                  double valor = entry.value;
                  return Chip(
                    label: Text(valor.toString()),
                    backgroundColor: Colors.indigo.shade50,
                    deleteIcon: const Icon(Icons.cancel, size: 18, color: Colors.redAccent),
                    onDeleted: () => _eliminarNumero(idx),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              MenuButton(
                text: 'Analizar Cantidades',
                onPressed: _analizar,
              ),
            ] else ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text('Lista vacía. Añade números arriba.', style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
            
            // Área de los resultados
            if (_resultado != null) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              const Center(
                child: Text('RESULTADOS DEL ANÁLISIS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildTarjetaResultado('Mayores\na 0', _resultado!.mayoresACero, Colors.green)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTarjetaResultado('Menores\na 0', _resultado!.menoresACero, Colors.red)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTarjetaResultado('Iguales\na 0', _resultado!.ceros, Colors.blueGrey)),
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: Text('Total evaluados: ${_resultado!.total}', style: const TextStyle(color: Colors.grey)),
              )
            ]
          ],
        ),
      ),
    );
  }
}
