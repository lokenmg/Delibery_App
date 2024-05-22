import 'package:delibery_app/screens/index.dart';

class DeliveryEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8080/';

  static String registrarEncargado() => '${baseUrl}encargados/crearCuenta';
  static String registrarCliente() => '${baseUrl}clientes/crearCuenta';
  static String registrarRepartidor() => '${baseUrl}repartidores/crearCuenta';
  static String login() => '${baseUrl}users/login';
  static String addStore(int idEncargado) => '$baseUrl/tiendas/$idEncargado';
}
