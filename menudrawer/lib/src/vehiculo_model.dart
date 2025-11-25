import 'dart:convert';

class Arreglo {
  String descripcion;
  String tipo;
  DateTime fecha;
  bool completado;

  Arreglo({
    required this.descripcion,
    required this.tipo,
    required this.fecha,
    this.completado = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'tipo': tipo,
      'fecha': fecha.toIso8601String(),
      'completado': completado,
    };
  }

  factory Arreglo.fromMap(Map<String, dynamic> map) {
    return Arreglo(
      descripcion: map['descripcion'] ?? '',
      tipo: map['tipo'] ?? '',
      fecha: DateTime.tryParse(map['fecha'] ?? '') ?? DateTime.now(),
      completado: map['completado'] ?? false,
    );
  }
}

class Vehiculo {
  final String marca;
  final String modelo;
  final String placa;

  
  int kilometraje;
  DateTime ultimaVisita;

  
  List<Arreglo> arreglos;

  Vehiculo({
    required this.marca,
    required this.modelo,
    required this.placa,
    required this.kilometraje,
    required this.ultimaVisita,
    this.arreglos = const [],
  });

  factory Vehiculo.fromMap(Map<String, dynamic> map) {
    return Vehiculo(
      marca: map['marca'] ?? '',
      modelo: map['modelo'] ?? '',
      placa: map['placa'] ?? '',
      kilometraje: map['kilometraje'] ?? 0,
      ultimaVisita: DateTime.tryParse(map['ultima_visita'] ?? '') ??
          DateTime.now(),
      arreglos: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'kilometraje': kilometraje,
      'ultima_visita': ultimaVisita.toIso8601String(),
      'arreglos': arreglos.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Vehiculo.fromJson(String source) =>
      Vehiculo.fromMap(jsonDecode(source));
}
