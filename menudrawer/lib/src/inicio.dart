import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Backfire',
          style: TextStyle(
            fontFamily: 'BBH_Sans_Bogle',
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("images/dog.jpg"),
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'abv.carrera@yavirac.edu.ec',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'BBH_Sans_Bogle',
                    ),
                  ),
                ],
              ),
            ),
            _DrawerItem(icon: Icons.home, text: 'Inicio', route: '/inicio'),
            _DrawerItem(icon: Icons.car_repair, text: 'Vehículos', route: '/vehiculos'),
            _DrawerItem(icon: Icons.person, text: 'Perfil', route: '/perfil'),
            _DrawerItem(icon: Icons.notifications, text: 'Notificación', route: '/notificacion'),
            _DrawerItem(icon: Icons.build, text: 'Servicios', route: '/servicios'),
            const Divider(color: Colors.white54),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text(
                "Cerrar sesión",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'BBH_Sans_Bogle',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a Backfire',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontFamily: 'BBH_Sans_Bogle',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.qr_code_scanner, color: Colors.green),
              label: Text(
                'Escanear QR',
                style: TextStyle(
                  fontFamily: 'BBH_Sans_Bogle',
                  color: Colors.green,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Fondo blanco para contraste
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/scanqr');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String route;

  const _DrawerItem({
    required this.icon,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'BBH_Sans_Bogle',
          fontSize: 16,
        ),
      ),
      onTap: () => Navigator.pushNamed(context, route),
      hoverColor: Colors.green.withOpacity(0.2),
    );
  }
}
