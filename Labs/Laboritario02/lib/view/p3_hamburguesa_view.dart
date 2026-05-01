import 'package:flutter/material.dart';
import '../components/atoms/menu_button.dart';
import '../controller/p3_hamburguesa_controller.dart';
import '../model/p3_hamburguesa_model.dart';

class P3HamburguesaView extends StatefulWidget {
  const P3HamburguesaView({super.key});

  @override
  State<P3HamburguesaView> createState() => _P3HamburguesaViewState();
}

class _P3HamburguesaViewState extends State<P3HamburguesaView> {
  final P3HamburguesaController _controller = P3HamburguesaController();

  int _cantSencillas = 0;
  int _cantDobles = 0;
  int _cantTriples = 0;
  bool _pagaConTarjeta = false;

  P3HamburguesaModel? _factura;

  void _calcular() {
    setState(() {
      _factura = _controller.calcularCuenta(
        cantSencillas: _cantSencillas,
        cantDobles: _cantDobles,
        cantTriples: _cantTriples,
        pagaConTarjeta: _pagaConTarjeta,
      );
    });
  }

  Widget _buildContadorHamburguesa(String nombre, double precio, int cantidad, ValueChanged<int> onChanged) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$${precio.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () {
                    if (cantidad > 0) onChanged(cantidad - 1);
                  },
                ),
                Text('$cantidad', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.indigo),
                  onPressed: () {
                    onChanged(cantidad + 1);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El Náufrago Satisfecho', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione su pedido:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 10),
            _buildContadorHamburguesa('Sencilla (S)', 20.0, _cantSencillas, (val) => setState(() => _cantSencillas = val)),
            _buildContadorHamburguesa('Doble (D)', 25.0, _cantDobles, (val) => setState(() => _cantDobles = val)),
            _buildContadorHamburguesa('Triple (T)', 28.0, _cantTriples, (val) => setState(() => _cantTriples = val)),
            
            const SizedBox(height: 15),
            Card(
              elevation: 2,
              child: SwitchListTile(
                title: const Text('Pago con Tarjeta', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Aplica 5% de cargo adicional'),
                activeColor: Colors.indigo,
                value: _pagaConTarjeta,
                onChanged: (val) {
                  setState(() => _pagaConTarjeta = val);
                },
              ),
            ),
            
            const SizedBox(height: 20),
            MenuButton(
              text: 'Generar Cuenta',
              onPressed: _calcular,
            ),
            
            if (_factura != null) ...[
              const SizedBox(height: 20),
              Card(
                color: Colors.indigo.shade50,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text('TICKET DE COMPRA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                          Text('\$${_factura!.subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Cargo por tarjeta:', style: TextStyle(fontSize: 16, color: Colors.red)),
                          Text('+\$${_factura!.cargoTarjeta.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('TOTAL A PAGAR:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${_factura!.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
