import 'package:delibery_app/entidades/modelos/apis/delivery_endpoints.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/categoria_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/tienda_model.dart';
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
      print(e);
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
      print(e);
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
      print(e);
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
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
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
      print(e);
      return {"status": 500, "message": "Error al obtener la tienda"};
    }
  }

  Future<List<CategoriaModelId>> getCategorias() async {
    try {
      Response response = await _dio.get(DeliveryEndpoints.getCategorias());
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => CategoriaModelId.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar categorías');
      }
    } catch (error) {
      print('Error en la petición GET: $error');
      throw Exception('Error al cargar categorías');
    }
  }

  Future<Map<String, dynamic>> postProducto(
      Map<String, dynamic> producto) async {
    try {
      final response =
          await _dio.post(DeliveryEndpoints.postProducto(), data: producto);
      print(response);
      return response.data;
    } catch (e) {
      print(e);
      return {"status": 500, "message": "Error al guardar el producto"};
    }
  }

  Future<List<ProductoModelId>> getProductos() async {
    try {
      Response response = await _dio.get(DeliveryEndpoints.getProductos());
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ProductoModelId.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos');
      }
    } catch (error) {
      print('Error en la petición GET: $error');
      throw Exception('Error al cargar productos');
    }
  }

  Future<List<ProductoModelId>> getProductosByTienda(int id) async {
    try {
      Response response =
          await _dio.get(DeliveryEndpoints.getProductosByTienda(id));
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ProductoModelId.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos');
      }
    } catch (error) {
      print('Error en la petición GET: $error');
      throw Exception('Error al cargar productos');
    }
  }

  Future<Map<String, dynamic>> crearVenta(VentaModel venta) async {
    try {
      final response = await _dio.post(DeliveryEndpoints.hacerComprar(),
          data: venta.toJson());
      print(response);
      return response.data;
    } catch (e) {
      print(e);
      return {"status": 500, "message": "Error al guardar la venta"};
    }
  }
}
