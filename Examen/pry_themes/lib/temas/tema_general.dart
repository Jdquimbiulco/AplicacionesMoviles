import 'package:flutter/material.dart';
import 'package:pry_themes/temas/tema_botones.dart';
import 'esquema_color.dart';
import 'tipografia.dart';
import 'tema_fondos.dart';
import 'tema_appbar.dart';
import 'tema_formularios.dart';

class TemaGeneral {
  static final ThemeData clasro = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: ColoresApp.primario,
      secondary: ColoresApp.secundario,
      background: ColoresApp.fondo,
      onPrimary: ColoresApp.textoClaro,
      onSecondary: ColoresApp.textoClaro,
    ),

    textTheme: TipografiaApp.texto,
    appBarTheme: TemaAppbar.estilo,
    elevatedButtonTheme: TemaBotones.botonPrincipal,
    outlinedButtonTheme: TemaBotones.botonSecundario,
    inputDecorationTheme: TemaFormularios.camposTexto,
    scaffoldBackgroundColor: ColoresApp.fondo,
  );
}
