class DeliveryEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8080/';

  static String registrarEncargado() => '${baseUrl}encargados/crearCuenta';
  static String registrarCliente() => '${baseUrl}clientes/crearCuenta';
}
