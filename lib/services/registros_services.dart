import 'package:delibery_app/modelos/apis/delivery_endpoints.dart';
import 'package:dio/dio.dart';

class RegistrosServices {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> registrarEncargado(
      Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.post(DeliveryEndpoints.registrarEncargado(), data: data);
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al registrar encargado"};
    }
  }

  Future<Map<String, dynamic>> registrarCliente(
      Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.post(DeliveryEndpoints.registrarCliente(), data: data);
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al registrar cliente"};
    }
  }
}
