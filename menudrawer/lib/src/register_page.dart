import 'package:flutter/material.dart';
import 'api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _usuarioController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "REGISTRARSE",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontFamily: 'BBH_Sans_Bogle',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _nombreController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'BBH_Sans_Bogle',
                  ),
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _correoController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'BBH_Sans_Bogle',
                  ),
                  decoration: const InputDecoration(
                    labelText: "Correo",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usuarioController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'BBH_Sans_Bogle',
                  ),
                  decoration: const InputDecoration(
                    labelText: "Usuario",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'BBH_Sans_Bogle',
                  ),
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'BBH_Sans_Bogle',
                  ),
                  decoration: const InputDecoration(
                    labelText: "Confirmar contraseña",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    final nombre = _nombreController.text.trim();
                    final correo = _correoController.text.trim();
                    final usuario = _usuarioController.text.trim();
                    final password = _passwordController.text.trim();
                    final confirm = _confirmPasswordController.text.trim();

                    if (nombre.isEmpty || correo.isEmpty || usuario.isEmpty || password.isEmpty || confirm.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Completa todos los campos'), backgroundColor: Colors.red),
                      );
                      return;
                    }
                    if (password != confirm) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Las contraseñas no coinciden'), backgroundColor: Colors.red),
                      );
                      return;
                    }
                    final error = await ApiService.registrarUsuario(
                      nombre: nombre,
                      correo: correo,
                      usuario: usuario,
                      password: password,
                    );
                    if (error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registro exitoso'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, '/login');
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error), backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text(
                    "Crear cuenta",
                    style: TextStyle(
                      fontFamily: 'BBH_Sans_Bogle',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "¿Ya tienes cuenta? Inicia sesión",
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
