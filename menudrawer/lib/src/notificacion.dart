import 'package:flutter/material.dart';

class NotificacionPage extends StatefulWidget {
  const NotificacionPage({super.key});

  @override
  State<NotificacionPage> createState() => _NotificacionPageState();
}

class _NotificacionPageState extends State<NotificacionPage> {
  // Lista de notificaciones simuladas
  List<String> notificaciones = [
    "Tu vehículo está en revisión",
    "Cambio de aceite programado para mañana",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A86B),
        title: const Text(
          'Notificaciones',
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: notificaciones.isEmpty
                  ? const Center(
                      child: Text(
                        'No tienes notificaciones',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'BBH_Sans_Bogle',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: notificaciones.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.green.withOpacity(0.1),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.notifications,
                                color: Colors.green),
                            title: Text(
                              notificaciones[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BBH_Sans_Bogle'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            // Botón de regreso
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A86B),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'BBH_Sans_Bogle',
                  fontWeight: FontWeight.bold,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/inicio', (route) => false);
              },
              child: const Text('Atrás'),
            ),
          ],
        ),
      ),
    );
  }
}
