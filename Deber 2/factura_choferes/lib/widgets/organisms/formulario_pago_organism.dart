import 'package:flutter/material.dart';
import '../../models/servicio_model.dart';
import '../molecules/cliente_data_molecule.dart';
import '../molecules/servicio_selection_molecule.dart';
import '../molecules/consumo_input_molecule.dart';
import '../molecules/descuentos_recargos_molecule.dart';
import '../atoms/button_atom.dart';

class FormularioPagoOrganism extends StatefulWidget {
  final VoidCallback onCalcular;
  final VoidCallback onLimpiar;
  final VoidCallback onCancelar;
  final Function(String nombre, String apellido, String email, TipoServicio tipo, String consumo, bool prontoPago, bool mora, bool adicional) onDatosChanged;

  const FormularioPagoOrganism({
    Key? key,
    required this.onCalcular,
    required this.onLimpiar,
    required this.onCancelar,
    required this.onDatosChanged,
  }) : super(key: key);

  @override
  State<FormularioPagoOrganism> createState() => _FormularioPagoOrganismState();
}

class _FormularioPagoOrganismState extends State<FormularioPagoOrganism> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController emailController;
  late TextEditingController consumoController;

  TipoServicio servicioSeleccionado = TipoServicio.agua;
  bool tieneProntoPago = false;
  bool tieneMora = false;
  bool tieneServicioAdicional = false;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    apellidoController = TextEditingController();
    emailController = TextEditingController();
    consumoController = TextEditingController();
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    emailController.dispose();
    consumoController.dispose();
    super.dispose();
  }

  void _notificarCambios() {
    widget.onDatosChanged(
      nombreController.text,
      apellidoController.text,
      emailController.text,
      servicioSeleccionado,
      consumoController.text,
      tieneProntoPago,
      tieneMora,
      tieneServicioAdicional,
    );
  }

  void _limpiar() {
    nombreController.clear();
    apellidoController.clear();
    emailController.clear();
    consumoController.clear();
    setState(() {
      servicioSeleccionado = TipoServicio.agua;
      tieneProntoPago = false;
      tieneMora = false;
      tieneServicioAdicional = false;
    });
    widget.onLimpiar();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClienteDataMolecule(
            nombreController: nombreController,
            apellidoController: apellidoController,
            emailController: emailController,
          ),
          const SizedBox(height: 24.0),
          ServicioSelectionMolecule(
            servicioSeleccionado: servicioSeleccionado,
            onChanged: (tipo) {
              setState(() {
                servicioSeleccionado = tipo;
                _notificarCambios();
              });
            },
          ),
          const SizedBox(height: 24.0),
          ConsumoInputMolecule(
            consumoController: consumoController,
          ),
          const SizedBox(height: 24.0),
          DescuentosRecargosMolecule(
            tieneProntoPago: tieneProntoPago,
            tieneMora: tieneMora,
            tieneServicioAdicional: tieneServicioAdicional,
            onProntoPagoChanged: (value) {
              setState(() {
                tieneProntoPago = value;
                _notificarCambios();
              });
            },
            onMoraChanged: (value) {
              setState(() {
                tieneMora = value;
                _notificarCambios();
              });
            },
            onServicioAdicionalChanged: (value) {
              setState(() {
                tieneServicioAdicional = value;
                _notificarCambios();
              });
            },
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ButtonAtom(
                  label: 'Calcular',
                  onPressed: () {
                    _notificarCambios();
                    widget.onCalcular();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: ButtonAtom(
                  label: 'Limpiar',
                  onPressed: _limpiar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: ButtonAtom(
                  label: 'Cancelar',
                  onPressed: widget.onCancelar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}