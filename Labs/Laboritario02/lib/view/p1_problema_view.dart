import 'package:flutter/material.dart';

import '../components/atoms/menu_button.dart';
import '../controller/p1_problema_controller.dart';
import '../model/p1_problema_model.dart';

class P1ProblemaView extends StatefulWidget {
  const P1ProblemaView({super.key});

  @override
  State<P1ProblemaView> createState() => _P1ProblemaViewState();
}

class _P1ProblemaViewState extends State<P1ProblemaView> {
  final P1ProblemaController _controller = P1ProblemaController();
  final TextEditingController _sueldoBaseController = TextEditingController(text: '1000');
  final TextEditingController _comisionController = TextEditingController(text: '5');
  final TextEditingController _nombreProductoController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController(text: '1');

  final List<P1ProductoModel> _productos = [];
  P1FacturaModel? _factura;

  @override
  void dispose() {
    _sueldoBaseController.dispose();
    _comisionController.dispose();
    _nombreProductoController.dispose();
    _precioController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _agregarProducto() {
    FocusScope.of(context).unfocus();

    final nombre = _nombreProductoController.text.trim();
    final precio = double.tryParse(_precioController.text.trim());
    final cantidad = int.tryParse(_cantidadController.text.trim());

    if (nombre.isEmpty || precio == null || cantidad == null || precio <= 0 || cantidad <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verifica nombre, precio y cantidad del producto.')),
      );
      return;
    }

    setState(() {
      _productos.add(
        P1ProductoModel(nombre: nombre, precio: precio, cantidad: cantidad),
      );
      _factura = null;
      _nombreProductoController.clear();
      _precioController.clear();
      _cantidadController.text = '1';
    });
  }

  void _eliminarProducto(int index) {
    setState(() {
      _productos.removeAt(index);
      _factura = null;
    });
  }

  void _limpiarTodo() {
    setState(() {
      _productos.clear();
      _factura = null;
      _nombreProductoController.clear();
      _precioController.clear();
      _cantidadController.text = '1';
    });
  }

  void _generarFactura() {
    FocusScope.of(context).unfocus();

    if (_productos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un producto para generar la factura.')),
      );
      return;
    }

    final sueldoBase = double.tryParse(_sueldoBaseController.text.trim()) ?? 0;
    final comisionPorcentaje = double.tryParse(_comisionController.text.trim()) ?? 0;

    setState(() {
      _factura = _controller.calcularVenta(
        productos: List<P1ProductoModel>.from(_productos),
        sueldoBaseVendedor: sueldoBase,
        comisionVendedorPorcentaje: comisionPorcentaje,
      );
    });
  }

  Widget _buildMoneyRow(String label, double value, {Color? color, bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problema 1: Ventas y Sueldo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionCard(
              title: 'Datos del Vendedor',
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _sueldoBaseController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Sueldo Base (\$)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _comisionController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Comisión (%)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: 'Agregar Producto a la Venta',
              child: Column(
                children: [
                  TextField(
                    controller: _nombreProductoController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Producto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _precioController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Precio Unitario (\$)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _cantidadController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Cantidad',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade200,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: _agregarProducto,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Agregar a la Lista'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lista de Productos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                TextButton(
                  onPressed: _productos.isEmpty ? null : _limpiarTodo,
                  child: const Text('Limpiar'),
                ),
              ],
            ),
            if (_productos.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Todavía no agregas productos.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _productos.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final producto = _productos[index];
                    return ListTile(
                      title: Text(producto.nombre, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${producto.cantidad} x \$${producto.precio.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${producto.total.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                          IconButton(
                            onPressed: () => _eliminarProducto(index),
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            MenuButton(text: 'Generar Factura', onPressed: _generarFactura),
            if (_factura != null) ...[
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.indigo.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'FACTURA DE VENTA',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ),
                      const Divider(height: 24, thickness: 1.2),
                      _buildMoneyRow('Subtotal:', _factura!.subtotal),
                      const SizedBox(height: 8),
                      _buildMoneyRow('Descuento (20%):', -_factura!.descuento, color: Colors.green),
                      const SizedBox(height: 8),
                      _buildMoneyRow('IVA (15%):', _factura!.iva, color: Colors.redAccent),
                      const Divider(height: 24, thickness: 1.2),
                      _buildMoneyRow('TOTAL A PAGAR:', _factura!.totalPagar, bold: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'LIQUIDACIÓN DEL VENDEDOR',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ),
                      const Divider(height: 24, thickness: 1.2),
                      _buildMoneyRow('Comisión ganada:', _factura!.comision, color: Colors.indigo),
                      const SizedBox(height: 8),
                      _buildMoneyRow('SUELDO TOTAL:', _factura!.sueldoFinalVendedor, bold: true, color: Colors.indigo),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
