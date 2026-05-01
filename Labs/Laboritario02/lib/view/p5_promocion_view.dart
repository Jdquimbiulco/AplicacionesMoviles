import 'package:flutter/material.dart';
import '../components/atoms/menu_button.dart';
import '../controller/p5_promocion_controller.dart';
import '../model/p5_promocion_model.dart';

class P5PromocionView extends StatefulWidget {
  const P5PromocionView({super.key});

  @override
  State<P5PromocionView> createState() => _P5PromocionViewState();
}

class _P5PromocionViewState extends State<P5PromocionView> {
  final P5PromocionController _controller = P5PromocionController();
  final TextEditingController _inputController = TextEditingController();

  final List<double> _precios = [];
  P5PromocionModel? _resultado;

  void _agregarPrecio() {
    FocusScope.of(context).unfocus();
    final texto = _inputController.text.trim();
    if (texto.isEmpty) return;

    final precio = double.tryParse(texto);
    if (precio != null && precio >= 0) {
      setState(() {
        _precios.add(precio);
        _resultado = null;
      });
      _inputController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa un precio válido mayor o igual a 0.')),
      );
    }
  }

  void _eliminarPrecio(int index) {
    setState(() {
      _precios.removeAt(index);
      _resultado = null;
    });
  }

  void _calcular() {
    if (_precios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un artículo para calcular.')),
      );
      return;
    }

    setState(() {
      _resultado = _controller.calcularPromociones(_precios);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promociones', style: TextStyle(color: Colors.white, fontSize: 18)),
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
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Precio del artículo (\$)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onSubmitted: (_) => _agregarPrecio(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _agregarPrecio,
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: const Text('Añadir', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            if (_precios.isNotEmpty) ...[
              const Text('Carrito de Compras:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _precios.asMap().entries.map((entry) {
                  int idx = entry.key;
                  double valor = entry.value;
                  return Chip(
                    label: Text('\$${valor.toStringAsFixed(2)}'),
                    backgroundColor: Colors.indigo.shade50,
                    deleteIcon: const Icon(Icons.cancel, size: 18, color: Colors.redAccent),
                    onDeleted: () => _eliminarPrecio(idx),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              MenuButton(
                text: 'Calcular Total',
                onPressed: _calcular,
              ),
            ] else ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text('Carrito vacío. Añade precios arriba.', style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
            
            if (_resultado != null) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Card(
                color: Colors.indigo,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('TICKET DE COMPRA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      const Divider(color: Colors.white54),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:', style: TextStyle(color: Colors.white70)),
                          Text('\$${_resultado!.totalOriginal.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Descuento:', style: TextStyle(color: Colors.greenAccent)),
                          Text('-\$${_resultado!.totalDescuento.toStringAsFixed(2)}', style: const TextStyle(color: Colors.greenAccent)),
                        ],
                      ),
                      const Divider(color: Colors.white54),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('TOTAL A PAGAR:', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${_resultado!.totalPagar.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Desglose por Artículo:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _resultado!.articulos.length,
                itemBuilder: (context, index) {
                  final art = _resultado!.articulos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade50,
                        child: Text('${index + 1}', style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                      ),
                      title: Text('Precio: \$${art.precioOriginal.toStringAsFixed(2)}'),
                      subtitle: Text('Descuento: ${(art.porcentajeDescuento * 100).toInt()}% (-\$${art.montoDescuento.toStringAsFixed(2)})', style: const TextStyle(color: Colors.green)),
                      trailing: Text('\$${art.precioFinal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
