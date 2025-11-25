import 'package:flutter/material.dart';
import 'package:menudrawer/src/inicio.dart';
import 'package:menudrawer/src/notificacion.dart';
import 'package:menudrawer/src/perfil.dart';
import 'package:menudrawer/src/siguiente.dart';
import 'package:menudrawer/src/login_page.dart'; // ✅ Nombre correcto

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF000000), // Fondo negro
      child: Column(
        children: [
          // 🔹 Encabezado
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Andrew Carrera",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'BBH_Sans_Bogle',
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              "abv.carrera@yavirac.edu.ec",
              style: TextStyle(
                color: Colors.white70,
                fontFamily: 'BBH_Sans_Bogle',
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "images/Gato_(2)_REFON.jpg",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF00A86B),
              image: DecorationImage(
                image: AssetImage("images/kelvin.jpg"),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
          ),

          // 🔸 Menú principal
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  text: "Inicio",
                  context: context,
                  page: const InicioPage(),
                ),
                _buildDrawerItem(
                  icon: Icons.person,
                  text: "Perfil",
                  context: context,
                  page: const PerfilPage(),
                ),
                _buildDrawerItem(
                  icon: Icons.notifications,
                  text: "Notificaciones",
                  context: context,
                  page: const NotificacionPage(),
                ),
                _buildDrawerItem(
                  icon: Icons.arrow_forward,
                  text: "Siguiente",
                  context: context,
                  page: const SiguientePage(),
                ),
              ],
            ),
          ),

          // 🔻 Separador
          const Divider(color: Colors.white54),

          // 🔴 BOTÓN CERRAR SESIÓN (VISIBLE Y FUNCIONAL)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                label: const Text(
                  "Cerrar sesión",
                  style: TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // 🔴 Botón rojo
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Navega a la pantalla de login y limpia el stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔸 Método para crear cada opción del Drawer
  ListTile _buildDrawerItem({
    required IconData icon,
    required String text,
    required BuildContext context,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00A86B)),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'BBH_Sans_Bogle',
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
