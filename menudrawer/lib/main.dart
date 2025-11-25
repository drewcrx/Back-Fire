import 'package:flutter/material.dart';
import 'src/inicio.dart';
import 'src/perfil.dart';
import 'src/notificacion.dart';
import 'src/vehiculos.dart';
import 'src/editar_perfil.dart';
import 'src/agregar_vehiculo.dart';
import 'src/servicios.dart';
import 'src/scan_qr_page.dart';
import 'src/detalle_qr_page.dart';
import 'src/detalle_vehiculo.dart';
import 'src/login_page.dart';
import 'src/register_page.dart';
import 'src/forgot_password_page.dart';
import 'src/forgot_username_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Backfire',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFF00A86B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00A86B),
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'BBH_Sans_Bogle',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'BBH_Sans_Bogle',
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'BBH_Sans_Bogle',
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/inicio': (context) => const InicioPage(),
        '/perfil': (context) => const PerfilPage(),
        '/notificacion': (context) => const NotificacionPage(),
        '/editarperfil': (context) => const EditarPerfilPage(),
        '/vehiculos': (context) => VehiculosPage(),
        '/agregar_vehiculo': (context) => const AgregarVehiculoPage(),
        '/servicios': (context) => const ServiciosPage(),
        '/scanqr': (context) => ScanQRPage(),
        '/detalle_qr': (context) => const DetalleQRPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/forgot_username': (context) => const ForgotUsernamePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detalle_vehiculo') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetalleVehiculoPage(vehiculo: args['vehiculo']),
          );
        }
        return null;
      },
    );
  }
}
