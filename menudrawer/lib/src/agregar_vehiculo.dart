import 'package:flutter/material.dart';
import 'api_service.dart';

class AgregarVehiculoPage extends StatefulWidget {
  const AgregarVehiculoPage({super.key});

  @override
  State<AgregarVehiculoPage> createState() => _AgregarVehiculoPageState();
}

class _AgregarVehiculoPageState extends State<AgregarVehiculoPage> {
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final placaController = TextEditingController();
  final kilometrajeController = TextEditingController();
  final ultimaVisitaController = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    marcaController.dispose();
    modeloController.dispose();
    placaController.dispose();
    kilometrajeController.dispose();
    ultimaVisitaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Agregar Vehículo', style: TextStyle(fontFamily: 'BBH_Sans_Bogle', color: Colors.black)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingrese los datos del vehículo:',
                style: TextStyle(
                  color: Colors.green, fontSize: 18, fontFamily: 'BBH_Sans_Bogle',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: marcaController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Marca',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: modeloController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: placaController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Placa',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: kilometrajeController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Kilometraje',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ultimaVisitaController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Última visita (YYYY-MM-DD)',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Atrás', style: TextStyle(fontFamily: 'BBH_Sans_Bogle', fontSize: 16)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _enviando
                        ? null
                        : () async {
                            final marca = marcaController.text.trim();
                            final modelo = modeloController.text.trim();
                            final placa = placaController.text.trim();
                            final kilometraje = kilometrajeController.text.trim();
                            final ultimaVisita = ultimaVisitaController.text.trim();

                            if (marca.isEmpty || modelo.isEmpty || placa.isEmpty || kilometraje.isEmpty || ultimaVisita.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Completa todos los campos'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            setState(() => _enviando = true);
                            final exito = await ApiService.agregarVehiculo(
                              marca: marca,
                              modelo: modelo,
                              placa: placa,
                              kilometraje: kilometraje,
                              ultimaVisita: ultimaVisita,
                            );
                            setState(() => _enviando = false);
                            if (exito) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Vehículo agregado correctamente'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error al guardar'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    child: _enviando
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green),
                          )
                        : const Text('Guardar', style: TextStyle(fontFamily: 'BBH_Sans_Bogle', fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
