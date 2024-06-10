class DeliveryEndpoints {
  static const String baseUrl =
      'https://deliveryapi-production-d7a1.up.railway.app/';
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
  static String getProductoById(int id) => '${baseUrl}productos/$id';
  static String getProductosByTienda(int id) =>
      '${baseUrl}productos/findAllByTienda/$id';
  static String getVentasByIdCliente(int id) =>
      '${baseUrl}ventas/allComprasPorCliente/$id';
  static String getTipoPagoById(int id) => '${baseUrl}tipoPago/$id';
  static String getEstadoPagoById(int id) => '${baseUrl}estadoPago/$id';
  static String getEstadoPedidoById(int id) => '${baseUrl}estadoPedido/$id';

  static String postProducto() => '${baseUrl}productos';
  static String postTienda(int id) => '${baseUrl}tienda/$id';

  static String hacerComprar() => '${baseUrl}ventas';

  static String putProducto(int id) => '${baseUrl}productos/$id';
}
