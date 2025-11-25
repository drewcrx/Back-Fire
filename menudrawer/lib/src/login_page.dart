import 'package:flutter/material.dart';
import 'api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const green = Colors.green;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themed = Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'BBH_Sans_Bogle',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: green,
            fontFamily: 'BBH_Sans_Bogle',
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontFamily: 'BBH_Sans_Bogle',
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
      child: _buildForm(context),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: SingleChildScrollView(child: themed)),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/2.png', height: 300),
          const SizedBox(height: 30),

          // Correo
          TextFormField(
            controller: _emailController,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'BBH_Sans_Bogle',
            ),
            decoration: const InputDecoration(
              labelText: "Correo",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Ingresa un correo válido';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Contraseña
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'BBH_Sans_Bogle',
            ),
            decoration: const InputDecoration(
              labelText: "Contraseña",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              if (value.length < 6) {
                return 'Debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              if (_formKey.currentState?.validate() != true) return;

              final correo = _emailController.text.trim();
              final password = _passwordController.text.trim();

              final error = await ApiService.loginUsuario(
                correo: correo,
                password: password,
              );

              if (error == null) {
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/inicio');
              } else {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              }
            },
            child: const Text(
              "Iniciar sesión",
              style: TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
            child: const Text(
              "¿Olvidaste tu contraseña?",
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'BBH_Sans_Bogle',
                fontSize: 15,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/forgot_username'),
            child: const Text(
              "¿Olvidaste tu usuario?",
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'BBH_Sans_Bogle',
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: const Text(
              "¿No tienes cuenta? Regístrate",
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'BBH_Sans_Bogle',
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
