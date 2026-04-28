import 'package:flutter/material.dart';
import 'package:flutter_application_4/controller/amigos_controller.dart';

//atomos
class Label extends StatelessWidget {
  final String text;
  //constructor
  Label(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  NumberField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText: hint, border: OutlineInputBorder()),
  );
}

//Button
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}

//resultado
class ResultText extends StatelessWidget {
  final String text;

  ResultText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

//Molecula
class NumerosInput extends StatelessWidget {
  final TextEditingController aC;
  final TextEditingController bC;

  NumerosInput({super.key, required this.aC, required this.bC});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberField(controller: aC, hint: 'Número a'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: NumberField(controller: bC, hint: 'Número b'),
        ),
      ],
    );
  }
}

//organismo
class AmigosView extends StatefulWidget {
  const AmigosView({super.key});

  @override
  State<AmigosView> createState() => _AmigosViewState();
}

class _AmigosViewState extends State<AmigosView> {
  final ctrlA = TextEditingController();
  final ctrlB = TextEditingController();

  String resultado = '';

  final controller = AmigosController();

  void calcular() {
    setState(() {
      resultado = controller.procesarNumerosAmigos(ctrlA.text, ctrlB.text);
    });
  }

  @override
  void dispose() {
    ctrlA.dispose();
    ctrlB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Label('Números amigos'),
                SizedBox(height: 8),
                Text(
                  'Dos números enteros positivos son amigos si la suma de sus divisores propios coincide con el otro número.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                NumerosInput(aC: ctrlA, bC: ctrlB),
                SizedBox(height: 16),
                PrimaryButton(text: 'Verificar', onPressed: calcular),
                SizedBox(height: 16),
                ResultText(resultado),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//pagina
class AmigosPage extends StatelessWidget {
  const AmigosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de números amigos'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: Padding(padding: EdgeInsets.all(16.0), child: AmigosView()),
    );
  }
}
