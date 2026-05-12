import 'package:flutter/material.dart';
import 'package:pry_themes/temas/tema_botones.dart';

// Tipos de botones disponibles
enum TipoBotonPersonalizado { principal, secundario }

// ÁTOMO: Botón Personalizado
// Botón versátil con dos estilos (principal y secundario)
// Puede mostrar texto, icono, o ambos
class BotonPersonalizado extends StatelessWidget {
  const BotonPersonalizado({
    super.key,
    required this.texto,
    required this.onPressed,
    this.tipo = TipoBotonPersonalizado.principal,
    this.icono,
    this.expandir = false,
    this.habilitado = true,
  });

  final String texto;
  final VoidCallback? onPressed;
  final TipoBotonPersonalizado tipo;
  final IconData? icono;
  final bool expandir;
  final bool habilitado;

  @override
  Widget build(BuildContext context) {
    final accion = habilitado ? onPressed : null;

    Widget contenido = icono == null
        ? Text(texto)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, size: 18),
              const SizedBox(width: 8),
              Text(texto),
            ],
          );

    if (expandir) {
      contenido = SizedBox(
        width: double.infinity,
        child: Center(child: contenido),
      );
    }

    return switch (tipo) {
      TipoBotonPersonalizado.principal => ElevatedButton(
        style: TemaBotones.botonPrincipal.style,
        onPressed: accion,
        child: contenido,
      ),
      TipoBotonPersonalizado.secundario => OutlinedButton(
        style: TemaBotones.botonSecundario.style,
        onPressed: accion,
        child: contenido,
      ),
    };
  }
}
