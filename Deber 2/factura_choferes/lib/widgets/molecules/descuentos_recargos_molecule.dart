import 'package:flutter/material.dart';
import '../atoms/checkbox_atom.dart';
import '../atoms/label_atom.dart';

class DescuentosRecargosMolecule extends StatefulWidget {
  final bool tieneProntoPago;
  final bool tieneMora;
  final bool tieneServicioAdicional;
  final ValueChanged<bool> onProntoPagoChanged;
  final ValueChanged<bool> onMoraChanged;
  final ValueChanged<bool> onServicioAdicionalChanged;

  const DescuentosRecargosMolecule({
    Key? key,
    required this.tieneProntoPago,
    required this.tieneMora,
    required this.tieneServicioAdicional,
    required this.onProntoPagoChanged,
    required this.onMoraChanged,
    required this.onServicioAdicionalChanged,
  }) : super(key: key);

  @override
  State<DescuentosRecargosMolecule> createState() =>
      _DescuentosRecargosMoleculeState();
}

class _DescuentosRecargosMoleculeState
    extends State<DescuentosRecargosMolecule> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelAtom(
          text: 'Descuentos y Recargos',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        CheckboxAtom(
          value: widget.tieneProntoPago,
          onChanged: (value) {
            widget.onProntoPagoChanged(value ?? false);
          },
          label: 'Pronto Pago (10% descuento)',
        ),
        CheckboxAtom(
          value: widget.tieneMora,
          onChanged: (value) {
            widget.onMoraChanged(value ?? false);
          },
          label: 'Mora (5% recargo)',
        ),
        CheckboxAtom(
          value: widget.tieneServicioAdicional,
          onChanged: (value) {
            widget.onServicioAdicionalChanged(value ?? false);
          },
          label: 'Servicio Adicional (\$5.00)',
        ),
      ],
    );
  }
}