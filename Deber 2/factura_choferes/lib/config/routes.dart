import 'package:flutter/material.dart';
import '../views/main_app_view.dart';
import '../views/home_view.dart';
import '../views/formulario_pago_view.dart';
import '../views/resumen_pago_view.dart';
import '../views/homepage_view.dart';
import '../views/resultado_view.dart';
import '../controllers/chofer_controller.dart';

class Routes {
  static const String mainApp = '/';
  
  // Rutas para Pagos de Servicios Básicos
  static const String pagosHome = '/pagos/home';
  static const String pagosFormulario = '/formulario'; // Mantenemos esta para compatibilidad con home_view.dart
  static const String pagosResumen = '/resumen'; // Mantenemos esta para compatibilidad con formulario_pago_view.dart

  // Rutas para Factura de Choferes
  static const String choferesHome = '/choferes/home';
  static const String choferesResultado = '/resultado'; // Mantenemos esta para compatibilidad con homepage_view.dart

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainApp:
        return MaterialPageRoute(builder: (_) => const MainAppView());

      // Pagos de Servicios Básicos
      case pagosHome:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case pagosFormulario:
        return MaterialPageRoute(builder: (_) => const FormularioPagoView());
      case pagosResumen:
        return MaterialPageRoute(
          builder: (_) => const ResumenPagoView(),
          settings: settings, // Pasar settings para recuperar los argumentos (Pago)
        );

      // Factura de Choferes
      case choferesHome:
        return MaterialPageRoute(builder: (_) => const HomePageView());
      case choferesResultado:
        final ChoferController controller = settings.arguments as ChoferController;
        return MaterialPageRoute(
          builder: (_) => ResultadoView(controller: controller),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('Ruta no encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
