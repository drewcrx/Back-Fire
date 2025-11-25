import 'package:flutter/material.dart';
import 'vehiculo_model.dart';
import 'detalle_vehiculo.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String nombre = "Juan Pérez";
    final String email = "juan.perez@email.com";

    final List<Vehiculo> vehiculosCliente = [
      Vehiculo(
        marca: 'Toyota',
        modelo: 'Hilux',
        placa: 'ABC-123',
        kilometraje: 0,
        ultimaVisita: DateTime.now(),
        arreglos: [],
      ),
      Vehiculo(
        marca: 'Chevrolet',
        modelo: 'Spark GT',
        placa: 'XYZ-789',
        kilometraje: 0,
        ultimaVisita: DateTime.now(),
        arreglos: [],
      ),
    ];

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
            const Text(
              'Vehículos',
              style: TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                fontSize: 18,
                color: Colors.green,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: vehiculosCliente.length,
                itemBuilder: (context, index) {
                  final vehiculo = vehiculosCliente[index];
                  return Card(
                    color: Colors.green.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.directions_car, color: Colors.green),
                      title: Text(
                        '${vehiculo.marca} ${vehiculo.modelo}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'BBH_Sans_Bogle',
                        ),
                      ),
                      subtitle: Text(
                        'Placa: ${vehiculo.placa}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'BBH_Sans_Bogle',
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.green, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetalleVehiculoPage(vehiculo: vehiculo),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
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
