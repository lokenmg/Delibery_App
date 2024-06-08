class DeliveryEndpoints {
  static const String baseUrl = 'http://192.168.1.149:8080/';
//spring.datasource.url = jdbc:postgresql://localhost:5432/newdelivery?useUnicode=true&characterEncoding=UTF-8

  static String registrarEncargado() => '${baseUrl}encargados/crearCuenta';
  static String registrarCliente() => '${baseUrl}clientes/crearCuenta';
  static String registrarRepartidor() => '${baseUrl}repartidores/crearCuenta';

  static String login() => '${baseUrl}users/login';

  static String getEncargado(int id) => '${baseUrl}encargados/$id';
  static String getCliente(int id) => '${baseUrl}clientes/$id';
  static String getRepartidor(int id) => '${baseUrl}repartidores/$id';
  static String getTienda(int id) => '${baseUrl}tienda/$id';
  static String getCategorias() => '${baseUrl}categorias';
  static String getProductos() => '${baseUrl}productos';
  static String getProductosByTienda(int id) =>
      '${baseUrl}productos/findAllByTienda/$id';

  static String postProducto() => '${baseUrl}productos';
  static String postTienda(int id) => '${baseUrl}tienda/$id';

  static String hacerComprar() => '${baseUrl}ventas';
}
