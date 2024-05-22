import 'package:delibery_app/modelos/apis/delivery_endpoints.dart';
import 'package:delibery_app/modelos/models/apiModels/token_model.dart';
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

  Future<Map<String, dynamic>> registrarRepartidor(
      Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.post(DeliveryEndpoints.registrarRepartidor(), data: data);
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al registrar repartidor"};
    }
  }

  Future<TokenModel> login(Map<String, dynamic> data) async {
    TokenModel? tokenModel;
    try {
      final response = await _dio.post(DeliveryEndpoints.login(), data: data);
      return tokenModel = TokenModel.fromJson(response.data);
    } catch (e) {
      tokenModel = TokenModel(
          username: "", message: "Error al iniciar sesión", token: "");
      return tokenModel;
    }
  }
}
