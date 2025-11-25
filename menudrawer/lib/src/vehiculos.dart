import 'package:flutter/material.dart';
import 'vehiculo_model.dart';
import 'api_service.dart';
import 'detalle_vehiculo.dart';

class VehiculosPage extends StatefulWidget {
  const VehiculosPage({super.key});

  @override
  State<VehiculosPage> createState() => _VehiculosPageState();
}

class _VehiculosPageState extends State<VehiculosPage> {
  late Future<List<Vehiculo>> _vehiculosFuture;

  @override
  void initState() {
    super.initState();
    _loadVehiculos();
  }

  void _loadVehiculos() {
    _vehiculosFuture = ApiService.obtenerVehiculos();
  }

  Future<void> _refrescarLista() async {
    setState(() {
      _loadVehiculos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Vehículos',
          style: TextStyle(fontFamily: 'BBH_Sans_Bogle'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Vehículos',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF00A86B),
                fontFamily: 'BBH_Sans_Bogle',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Vehiculo>>(
                future: _vehiculosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final lista = snapshot.data ?? [];

                  if (lista.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay vehículos registrados',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _refrescarLista,
                    child: ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        return _VehiculoItem(
                          vehiculo: lista[index],
                          onEliminar: _refrescarLista,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A86B),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Atrás',
                    style:
                        TextStyle(fontFamily: 'BBH_Sans_Bogle', fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: const Color(0xFF00A86B),
                    side: const BorderSide(color: Colors.green, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/agregar_vehiculo');
                    _refrescarLista();
                  },
                  child: const Text(
                    'Agregar vehículo',
                    style:
                        TextStyle(fontFamily: 'BBH_Sans_Bogle', fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VehiculoItem extends StatelessWidget {
  final Vehiculo vehiculo;
  final Function onEliminar;

  const _VehiculoItem({required this.vehiculo, required this.onEliminar});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () async {
                final confirmado = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text(
                      "Confirmar eliminación",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'BBH_Sans_Bogle',
                      ),
                    ),
                    content: const Text(
                      "¿Seguro que deseas eliminar este vehículo?",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'BBH_Sans_Bogle',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'BBH_Sans_Bogle',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "Eliminar",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: 'BBH_Sans_Bogle',
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirmado == true) {
                  final exito = await ApiService.eliminarVehiculoPorPlaca(
                    vehiculo.placa,
                  );

                  if (exito) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Vehículo eliminado correctamente"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    onEliminar();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error al eliminar"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.green,
              size: 16,
            ),
          ],
        ),
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
  }
}
