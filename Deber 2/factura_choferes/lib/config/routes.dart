import 'package:flutter/material.dart';
import 'package:factura_choferes/presentation/pages/home_page.dart';
import 'package:factura_choferes/presentation/pages/resultado_page.dart';
import 'package:factura_choferes/controllers/chofer_controller.dart';

class Routes {
  static const String homePage = '/';
  static const String resultadoPage = '/resultado';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      case resultadoPage:
        final ChoferController controller =
            settings.arguments as ChoferController;
        return MaterialPageRoute(
          builder: (_) => ResultadoPage(controller: controller),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Ruta no encontrada'),
            ),
          ),
        );
    }
  }
}
