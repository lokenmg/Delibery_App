import 'package:delibery_app/modelos/models/carrito.dart';
import 'package:flutter/material.dart';

class CarritoComprasProvider extends ChangeNotifier {
  List<CarritoModel> carrito = [];

  void agregarCarrito(CarritoModel carritoModel) {
    carrito.add(carritoModel);
    notifyListeners();
  }

  void eliminarCarrito(CarritoModel carritoModel) {
    carrito.remove(carritoModel);
    notifyListeners();
  }

  void eliminarCarritoPorIndex(int index) {
    carrito.removeAt(index);
    notifyListeners();
  }

  void limpiarCarrito() {
    carrito = [];
    notifyListeners();
  }

  CarritoModel? buscarPorId(int id) {
    for (var element in carrito) {
      if (element.producto?.id == id) {
        return element;
      }
    }
    return null;
  }

  void modificarElemento(int id, CarritoModel nuevoElemento) {
    CarritoModel? elementoExistente = buscarPorId(id);
    if (elementoExistente != null) {
      int index = carrito.indexOf(elementoExistente);
      carrito[index] = nuevoElemento;
      notifyListeners();
    }
  }

  double get total {
    double total = 0;
    for (var element in carrito) {
      total += element.subtotal!;
    }
    return total;
  }
}
