import 'dart:convert';
import 'package:http/http.dart' as http;
import 'vehiculo_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.2:3000";

  // ===== Vehículos =====
  static Future<List<Vehiculo>> obtenerVehiculos() async {
    final url = Uri.parse("${baseUrl}/vehiculos");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((v) => Vehiculo.fromMap(v)).toList();
    } else {
      throw Exception("Error al obtener vehículos");
    }
  }

  static Future<Vehiculo?> buscarPorPlaca(String placa) async {
    final url = Uri.parse("${baseUrl}/vehiculos/$placa");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return Vehiculo.fromMap(data);
    }
    return null;
  }

  static Future<bool> agregarVehiculo({
    required String marca,
    required String modelo,
    required String placa,
    String? kilometraje,
    String? ultimaVisita,
  }) async {
    final url = Uri.parse("${baseUrl}/vehiculos");

    final Map<String, dynamic> bodyData = {
      "marca": marca,
      "modelo": modelo,
      "placa": placa,
    };

    if (kilometraje != null && kilometraje.isNotEmpty) {
      bodyData["kilometraje"] = int.tryParse(kilometraje) ?? 0;
    }

    if (ultimaVisita != null && ultimaVisita.isNotEmpty) {
      bodyData["ultima_visita"] = ultimaVisita;
    }

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bodyData),
    );

    return res.statusCode == 200;
  }

  // ===== Actualizar Vehículo (NUEVO) =====
  static Future<bool> actualizarVehiculo({
    required String placa,
    required int kilometraje,
    required String ultimaVisita,
  }) async {
    final url = Uri.parse("$baseUrl/vehiculos/$placa");

    final res = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "kilometraje": kilometraje,
        "ultima_visita": ultimaVisita,
      }),
    );

    return res.statusCode == 200;
  }

  // ===== Arreglos =====
  static Future<List<Arreglo>> obtenerArreglosPorPlaca(String placa) async {
    final url = Uri.parse("${baseUrl}/vehiculos/$placa/arreglos");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;
      return data.map((e) => Arreglo.fromMap(e as Map<String, dynamic>)).toList();
    }

    throw Exception("Error al obtener arreglos");
  }

  static Future<bool> agregarArreglo({
    required String placa,
    required String descripcion,
    required String tipo,
  }) async {
    final url = Uri.parse("${baseUrl}/vehiculos/$placa/arreglos");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "descripcion": descripcion,
        "tipo": tipo,
      }),
    );

    return res.statusCode == 200;
  }

  // ===== Usuarios =====
  static Future<String?> registrarUsuario({
    required String nombre,
    required String correo,
    required String usuario,
    required String password,
  }) async {
    final url = Uri.parse("${baseUrl}/usuarios/register");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'usuario': usuario,
        'password': password,
      }),
    );

    if (res.statusCode == 200) return null;
    final data = jsonDecode(res.body);
    return data['error'] ?? "Error desconocido";
  }

  static Future<String?> loginUsuario({
    String? usuario,
    String? correo,
    required String password,
  }) async {
    final url = Uri.parse("${baseUrl}/usuarios/login");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario': usuario,
        'correo': correo,
        'password': password,
      }),
    );

    if (res.statusCode == 200) return null;

    try {
      final data = jsonDecode(res.body);
      return data['error'] ?? "Error de autenticación";
    } catch (_) {
      return "Error de autenticación";
    }
  }

  // ===== Eliminar Vehículo =====
  static Future<bool> eliminarVehiculoPorPlaca(String placa) async {
    final url = Uri.parse("${baseUrl}/vehiculos/$placa");
    final res = await http.delete(url);

    return res.statusCode == 200 || res.statusCode == 204;
  }
}
