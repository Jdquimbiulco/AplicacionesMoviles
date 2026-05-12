import 'package:flutter/material.dart';
import 'esquema_color.dart';

// TEMA: Estilos de Botones
// Define los estilos visuales para botones principales y secundarios
class TemaBotones {
  // Botón principal: azul con texto blanco y bordes redondeados
  static final botonPrincipal = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColoresApp.primario,
      foregroundColor: ColoresApp.textoClaro,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

  //boton secundario
  static final botonSecundario = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColoresApp.secundario,
      side: BorderSide(color: ColoresApp.primario),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
