import 'package:delibery_app/entidades/modelos/apis/delivery_endpoints.dart';
import 'package:dio/dio.dart';

class FuncionesTienda {
  final _dio = Dio();
  Future<Map<String, dynamic>> registrarTienda(
      Map<String, dynamic> data, int idEncargado) async {
    try {
      final response =
          await _dio.post(DeliveryEndpoints.addStore(idEncargado), data: data);
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al registrar tienda"};
    }
  }
}
