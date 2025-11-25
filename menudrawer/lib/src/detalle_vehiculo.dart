import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'vehiculo_model.dart';
import 'api_service.dart';

class DetalleVehiculoPage extends StatefulWidget {
  final Vehiculo vehiculo;

  const DetalleVehiculoPage({super.key, required this.vehiculo});

  @override
  State<DetalleVehiculoPage> createState() => _DetalleVehiculoPageState();
}

class _DetalleVehiculoPageState extends State<DetalleVehiculoPage> {
  final _descripcionController = TextEditingController();
  final _tipoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarArreglosInicial();
  }

  Future<void> _cargarArreglosInicial() async {
    try {
      final lista = await ApiService.obtenerArreglosPorPlaca(widget.vehiculo.placa);
      if (!mounted) return;
      setState(() {
        widget.vehiculo.arreglos = lista;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _descripcionController.dispose();
    _tipoController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------
  //  AGREGAR ARREGLO
  // ---------------------------------------------------------
  void _agregarArreglo() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Agregar arreglo',
          style: TextStyle(
            fontFamily: 'BBH_Sans_Bogle',
            color: Colors.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _descripcionController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Descripción',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tipoController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Tipo de arreglo',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _descripcionController.clear();
              _tipoController.clear();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final desc = _descripcionController.text.trim();
              final tipo = _tipoController.text.trim();

              if (desc.isEmpty || tipo.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Completa descripción y tipo'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final ok = await ApiService.agregarArreglo(
                placa: widget.vehiculo.placa,
                descripcion: desc,
                tipo: tipo,
              );

              if (!mounted) return;

              if (ok) {
                final nuevos = await ApiService.obtenerArreglosPorPlaca(widget.vehiculo.placa);
                setState(() {
                  widget.vehiculo.arreglos = nuevos;
                });

                Navigator.pop(context);
                _descripcionController.clear();
                _tipoController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Arreglo agregado'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al guardar arreglo'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'Agregar',
              style: TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  //  ACTUALIZAR VEHÍCULO (modal completo)
  // ---------------------------------------------------------
  void _actualizarVehiculo() {
    final kmController = TextEditingController(
      text: widget.vehiculo.kilometraje.toString(),
    );

    DateTime fechaActual = widget.vehiculo.ultimaVisita;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text(
              "Actualizar Vehículo",
              style: TextStyle(
                fontFamily: 'BBH_Sans_Bogle',
                color: Colors.white,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: kmController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Kilometraje",
                    labelStyle: TextStyle(color: Colors.white54),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: fechaActual,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (fecha != null) {
                      setModalState(() {
                        fechaActual = fecha;
                      });
                    }
                  },
                  child: Text(
                    "Fecha última visita: ${fechaActual.day}/${fechaActual.month}/${fechaActual.year}",
                    style: const TextStyle(
                      fontFamily: 'BBH_Sans_Bogle',
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final km = int.tryParse(kmController.text.trim()) ?? 0;

                  final ok = await ApiService.actualizarVehiculo(
                    placa: widget.vehiculo.placa,
                    kilometraje: km,
                    ultimaVisita: fechaActual.toIso8601String(),
                  );

                  if (!mounted) return;

                  if (ok) {
                    setState(() {
                      widget.vehiculo.kilometraje = km;
                      widget.vehiculo.ultimaVisita = fechaActual;
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Vehículo actualizado"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error al actualizar"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    fontFamily: 'BBH_Sans_Bogle',
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${widget.vehiculo.marca} ${widget.vehiculo.modelo}',
          style: const TextStyle(fontFamily: 'BBH_Sans_Bogle'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 3,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: widget.vehiculo.placa,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Placa: ${widget.vehiculo.placa}',
              style: const TextStyle(
                color: Color(0xFF00A86B),
                fontSize: 20,
                fontFamily: 'BBH_Sans_Bogle',
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Historial de Arreglos',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'BBH_Sans_Bogle',
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: widget.vehiculo.arreglos.length,
                itemBuilder: (context, index) {
                  final arreglo = widget.vehiculo.arreglos[index];

                  return Card(
                    color: Colors.green.withOpacity(0.15),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(
                        arreglo.completado ? Icons.check_circle : Icons.pending,
                        color: arreglo.completado ? Colors.green : Colors.orange,
                      ),
                      title: Text(
                        arreglo.descripcion,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'BBH_Sans_Bogle',
                        ),
                      ),
                      subtitle: Text(
                        '${arreglo.tipo} - ${arreglo.fecha.day}/${arreglo.fecha.month}/${arreglo.fecha.year}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'BBH_Sans_Bogle',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 25,
                      ),
                    ),
                    onPressed: _agregarArreglo,
                    child: const Text(
                      'Agregar Arreglo',
                      style: TextStyle(
                        fontFamily: 'BBH_Sans_Bogle',
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 25,
                      ),
                    ),
                    onPressed: _actualizarVehiculo,
                    child: const Text(
                      'Actualizar Vehículo',
                      style: TextStyle(
                        fontFamily: 'BBH_Sans_Bogle',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
