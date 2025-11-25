import 'package:flutter/material.dart';

class ForgotUsernamePage extends StatefulWidget {
  const ForgotUsernamePage({super.key});

  @override
  State<ForgotUsernamePage> createState() => _ForgotUsernamePageState();
}

class _ForgotUsernamePageState extends State<ForgotUsernamePage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Recuperar Usuario",
          style: TextStyle(fontFamily: 'BBH_Sans_Bogle', color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ingresa tu correo registrado para recuperar tu usuario",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: 'BBH_Sans_Bogle',
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'BBH_Sans_Bogle',
                ),
                decoration: const InputDecoration(
                  labelText: "Correo electrónico",
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Tu usuario ha sido enviado a tu correo.",
                        style: TextStyle(fontFamily: 'BBH_Sans_Bogle'),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  "Enviar",
                  style: TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
