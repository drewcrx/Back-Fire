import 'package:flutter/material.dart';
import 'vehiculo_model.dart';
import 'detalle_vehiculo.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String nombre = "Andrew Carrera";
    final String email = "abv.carrera@yavirac.edu.ec";

    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/ajustes');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: const TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/editarperfil');
                },
                child: const Text(
                  'Editar Perfil',
                  style: TextStyle(fontFamily: 'BBH_Sans_Bogle', fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Spacer(), 

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Atrás',
                  style: TextStyle(fontFamily: 'BBH_Sans_Bogle'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
