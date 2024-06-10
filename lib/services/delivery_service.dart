import 'package:delibery_app/entidades/modelos/apis/delivery_endpoints.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/categoria_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/estado_pago_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/estado_pedido.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/tienda_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/tipo_pago_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/venta_completa_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/venta_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryService {
  final Dio _dio = Dio();
  DeliveryService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));
  }

  Future<Map<String, dynamic>> getEncargadoInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('usuario');
    try {
      final response = await _dio.get(DeliveryEndpoints.getEncargado(id!));
      return response.data;
    } catch (e) {
      return {
        "status": 500,
        "message": "Error al obtener información del encargado"
      };
    }
  }

  Future<Map<String, dynamic>> getClienteInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('usuario');
    try {
      final response = await _dio.get(DeliveryEndpoints.getCliente(id!));
      return response.data;
    } catch (e) {
      return {
        "status": 500,
        "message": "Error al obtener información del cliente"
      };
    }
  }

  Future<Map<String, dynamic>> getRepartidorInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('usuario');
    try {
      final response = await _dio.get(DeliveryEndpoints.getRepartidor(id!));
      return response.data;
    } catch (e) {
      return {
        "status": 500,
        "message": "Error al obtener información del repartidor"
      };
    }
  }

  Future<Map<String, dynamic>> postStore(TiendaModel tienda) async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('usuario');
    try {
      final response = await _dio.post(DeliveryEndpoints.postTienda(id!),
          data: tienda.toJson());
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al guardar la tienda"};
    }
  }

  Future<Map<String, dynamic>> getStore() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('usuario');
    try {
      final response = await _dio.get(DeliveryEndpoints.getTienda(id!));
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al obtener la tienda"};
    }
  }

  Future<List<CategoriaModelId>> getCategorias() async {
    try {
      Response response = await _dio.get(DeliveryEndpoints.getCategorias());
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => CategoriaModelId.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar categorías');
      }
    } catch (error) {
      throw Exception('Error al cargar categorías');
    }
  }

  Future<Map<String, dynamic>> postProducto(
      Map<String, dynamic> producto) async {
    try {
      final response =
          await _dio.post(DeliveryEndpoints.postProducto(), data: producto);
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al guardar el producto"};
    }
  }

  Future<Map<String, dynamic>> crearVenta(VentaModel venta) async {
    try {
      final response = await _dio.post(DeliveryEndpoints.hacerComprar(),
          data: venta.toJson());
      return response.data;
    } catch (e) {
      return {"status": 500, "message": "Error al guardar la venta"};
    }
  }

  Future<List<ProductoModelId>> getProductos() async {
    try {
      Response response = await _dio.get(DeliveryEndpoints.getProductos());
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ProductoModelId.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos');
      }
    } catch (error) {
      throw Exception('Error al cargar productos');
    }
  }

  Future<ProductoModelId> getProductoById(int id) async {
    try {
      Response response = await _dio.get(DeliveryEndpoints.getProductoById(id));
      if (response.statusCode == 200) {
        return ProductoModelId.fromJson(response.data);
      } else {
        throw Exception('Error al cargar producto');
      }
    } catch (e) {
      throw Exception('Error al cargar producto ${e.toString()}');
    }
  }

  Future<List<ProductoModelId>> getProductosByTienda(int id) async {
    try {
      Response response =
          await _dio.get(DeliveryEndpoints.getProductosByTienda(id));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ProductoModelId.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos');
      }
    } catch (error) {
      throw Exception('Error al cargar productos');
    }
  }

  Future<List<VentaCompletaModel>> getVentasByIdCliente() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('usuario');
    try {
      Response response =
          await _dio.get(DeliveryEndpoints.getVentasByIdCliente(id!));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => VentaCompletaModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar ventas');
      }
    } catch (error) {
      throw Exception('Error al cargar ventas');
    }
  }

  Future<TipoPagoModel> getTipoPagoById(int id) async {
    try {
      Response response = await _dio.get(DeliveryEndpoints.getTipoPagoById(id));
      if (response.statusCode == 200) {
        return TipoPagoModel.fromJson(response.data);
      } else {
        throw Exception('Error al cargar tipo de pago');
      }
    } catch (e) {
      throw Exception('Error al cargar tipo de pago ${e.toString()}');
    }
  }

  Future<EstadoPagoModel> getEstadoPagoById(int id) async {
    try {
      Response response =
          await _dio.get(DeliveryEndpoints.getEstadoPagoById(id));
      if (response.statusCode == 200) {
        return EstadoPagoModel.fromJson(response.data);
      } else {
        throw Exception('Error al cargar estado de pago');
      }
    } catch (e) {
      throw Exception('Error al cargar estado de pago ${e.toString()}');
    }
  }

  Future<EstadoPedidoModel> getEstadoPedidoById(int id) async {
    try {
      Response response =
          await _dio.get(DeliveryEndpoints.getEstadoPedidoById(id));
      if (response.statusCode == 200) {
        return EstadoPedidoModel.fromJson(response.data);
      } else {
        throw Exception('Error al cargar estado de pedido');
      }
    } catch (e) {
      throw Exception('Error al cargar estado de pedido ${e.toString()}');
    }
  }

  Future<ProductoModelId> putProducto(
      int id, Map<String, dynamic> producto) async {
    try {
      final response =
          await _dio.put(DeliveryEndpoints.putProducto(id), data: producto);
      return ProductoModelId.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al actualizar producto, ${e.toString()}');
    }
  }
}
