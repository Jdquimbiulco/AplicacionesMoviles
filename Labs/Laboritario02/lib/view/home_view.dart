import 'package:flutter/material.dart';
import '../components/atoms/menu_button.dart';
import 'p1_problema_view.dart';
import 'p2_salario_view.dart';
import 'p3_hamburguesa_view.dart';
import 'p4_cantidades_view.dart';
import 'p5_promocion_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Ejercicios', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              MenuButton(
                text: 'Problema 1',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const P1ProblemaView())),
              ),
              MenuButton(
                text: 'Problema 2: Salario',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const P2SalarioView())),
              ),
              MenuButton(
                text: 'Problema 3: Hamburguesas',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const P3HamburguesaView())),
              ),
              MenuButton(
                text: 'Problema 4: Cantidades',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const P4CantidadesView())),
              ),
              MenuButton(
                text: 'Problema 5: Promociones',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const P5PromocionView())),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
