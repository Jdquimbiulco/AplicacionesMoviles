import 'package:flutter/material.dart';
import 'package:pry_themes/modelos/servicio_lavado_modelo.dart';
import '../atomos/campo_texto.dart';
import '../atomos/selector_simple.dart';
import '../atomos/boton_personalizado.dart';

// MOLÉCULA: Formulario de Servicio
// Componente compuesto que combina átomos
// Permite al usuario ingresar datos del lavado y generar el modelo
class FormularioServicio extends StatefulWidget {
  const FormularioServicio({super.key, required this.onSubmit});

  final ValueChanged<ServicioLavadoModelo> onSubmit;

  @override
  State<FormularioServicio> createState() => _FormularioServicioState();
}

class _FormularioServicioState extends State<FormularioServicio> {
  // Controladores y estado para el formulario
  final TextEditingController _nombreCtrl = TextEditingController();
  TipoVehiculo _vehiculo = TipoVehiculo.auto; // Seleccionado por defecto
  TipoLavado _lavado = TipoLavado.basico; // Seleccionado por defecto
  ServicioAdicional _adicional =
      ServicioAdicional.ninguno; // Seleccionado por defecto

  @override
  void dispose() {
    _nombreCtrl.dispose();
    super.dispose();
  }

  // Al submit: arma el modelo y lo envía al padre (vista)
  void _submit() {
    final modelo = ServicioLavadoModelo(
      nombreCliente: _nombreCtrl.text.trim(),
      tipoVehiculo: _vehiculo,
      tipoLavado: _lavado,
      servicioAdicional: _adicional,
    );
    widget.onSubmit(modelo);
  }

  @override
  Widget build(BuildContext context) {
    // Construye el formulario con campos de entrada y selector de opciones
    return Column(
      children: [
        CampoTexto(
          controller: _nombreCtrl,
          label: 'Nombre del cliente',
          hint: 'Ingrese nombre',
        ),
        const SizedBox(height: 12),
        SelectorSimple<TipoVehiculo>(
          valor: _vehiculo,
          label: 'Tipo de vehículo',
          items: TipoVehiculo.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v.label())))
              .toList(),
          onChanged: (v) => setState(() => _vehiculo = v ?? TipoVehiculo.auto),
        ),
        const SizedBox(height: 12),
        SelectorSimple<TipoLavado>(
          valor: _lavado,
          label: 'Tipo de lavado',
          items: TipoLavado.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v.label())))
              .toList(),
          onChanged: (v) => setState(() => _lavado = v ?? TipoLavado.basico),
        ),
        const SizedBox(height: 12),
        SelectorSimple<ServicioAdicional>(
          valor: _adicional,
          label: 'Servicio adicional (opcional)',
          items: ServicioAdicional.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v.label())))
              .toList(),
          onChanged: (v) =>
              setState(() => _adicional = v ?? ServicioAdicional.ninguno),
        ),
        const SizedBox(height: 16),
        BotonPersonalizado(
          texto: 'Calcular y generar nota',
          expandir: true,
          onPressed: _submit,
          tipo: TipoBotonPersonalizado.principal,
        ),
      ],
    );
  }
}
