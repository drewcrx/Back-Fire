import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();
  String nombre = 'Andrew Carrera';
  String correo = 'abv.carrera@yavirac.edu.ec';
  String contrasena = '********';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A86B),
        title: const Text(
          'Editar Perfil',
          style: TextStyle(
            fontFamily: 'BBH_Sans_Bogle',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextFormField(
                initialValue: nombre,
                style: const TextStyle(
                  fontFamily: 'BBH_Sans_Bogle',
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: const TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    color: Colors.white70,
                  ),
                  prefixIcon: const Icon(Icons.person, color: Color(0xFF00A86B)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A86B), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A86B), width: 2),
                  ),
                ),
                onChanged: (value) => setState(() => nombre = value),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: correo,
                style: const TextStyle(
                  fontFamily: 'BBH_Sans_Bogle',
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: const TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    color: Colors.white70,
                  ),
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF00A86B)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A86B), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A86B), width: 2),
                  ),
                ),
                onChanged: (value) => setState(() => correo = value),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                initialValue: contrasena,
                style: const TextStyle(
                  fontFamily: 'BBH_Sans_Bogle',
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    color: Colors.white70,
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF00A86B)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A86B), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF00A86B), width: 2),
                  ),
                ),
                onChanged: (value) => setState(() => contrasena = value),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF00A86B),
                      textStyle:
                          const TextStyle(fontFamily: 'BBH_Sans_Bogle'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: Color(0xFF00A86B), width: 2),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      foregroundColor: Colors.white,
                      textStyle:
                          const TextStyle(fontFamily: 'BBH_Sans_Bogle'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Información actualizada con éxito',
                              style: TextStyle(fontFamily: 'BBH_Sans_Bogle'),
                            ),
                            backgroundColor: Color(0xFF00A86B),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
