import 'package:delibery_app/entidades/modelos/geocidong_model.dart';
import 'package:dio/dio.dart';

class PeticionesCopomex {
  final String _urlBase = 'https://api.copomex.com/query/';
  final String _token = "ea95615f-7982-472a-8525-f5f19b8d8713";

  final dio = Dio();
  Future<Geocoding> getCpGeoEncoding(String codigoPostal) async {
    Geocoding? resultado;
    final response = await dio.get(
        "${_urlBase}info_cp_geocoding/$codigoPostal?type=simplified&token=$_token");
    resultado = Geocoding.fromJson(response.data);
    return resultado;
  }
}
