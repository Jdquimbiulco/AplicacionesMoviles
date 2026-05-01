import 'package:flutter/material.dart';
import '../components/atoms/menu_button.dart';
import '../controller/p2_salario_controller.dart';
import '../model/p2_salario_model.dart';

class P2SalarioView extends StatefulWidget {
  const P2SalarioView({super.key});

  @override
  State<P2SalarioView> createState() => _P2SalarioViewState();
}

class _P2SalarioViewState extends State<P2SalarioView> {
  final _salarioController = TextEditingController(text: '1500');
  final _aniosController = TextEditingController(text: '6');
  final P2SalarioController _controller = P2SalarioController();
  
  List<P2SalarioModel> _historial = [];
  double _salarioFinal = 0;

  void _calcular() {
    FocusScope.of(context).unfocus();

    double salarioInicial = double.tryParse(_salarioController.text) ?? 1500;
    int anios = int.tryParse(_aniosController.text) ?? 6;

    final resultados = _controller.calcularSalarios(salarioInicial, anios);
    
    setState(() {
      _historial = resultados;
      if (resultados.isNotEmpty) {
        _salarioFinal = resultados.last.monto + (resultados.last.monto * 0.10);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 2: Salario', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _salarioController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Salario Inicial (\$)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _aniosController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cant. de Años',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            MenuButton(
              text: 'Calcular Salario',
              onPressed: _calcular,
            ),
            const SizedBox(height: 10),
            const Divider(),
            if (_historial.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Salario al cabo de ${_aniosController.text} años: \$${_salarioFinal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _historial.length,
                  itemBuilder: (context, index) {
                    final item = _historial[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.shade100,
                          child: Text('${item.anio}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                        ),
                        title: Text('Salario del Año ${item.anio}'),
                        trailing: Text(
                          '\$${item.monto.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
