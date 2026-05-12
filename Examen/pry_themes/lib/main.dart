import 'package:flutter/material.dart';
import 'package:pry_themes/vistas/vista_lavado.dart';
import 'package:pry_themes/vistas/vista_nota_venta.dart';

// PUNTO DE ENTRADA: Aplicación Lavadora de Autos
// Define rutas, tema global y configura la app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores del tema
    final primary = Colors.blue; // Azul para AppBar y elementos principales
    final lightBg = Colors.grey.shade50; // Fondo claro

    return MaterialApp(
      title: 'Lavadora de autos',
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      theme: ThemeData(
        // Configuración de colores
        primaryColor: primary,
        scaffoldBackgroundColor: lightBg,
        // AppBar azul
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        // Botones redondeados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // Campos de texto con borde
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      // Ruta inicial
      initialRoute: '/lavado',
      // Definición de rutas
      routes: {
        '/lavado': (context) => const VistaLavado(), // Formulario
        '/notaVenta': (context) => const VistaNotaVenta(), // Resultado
      },
    );
  }
}
