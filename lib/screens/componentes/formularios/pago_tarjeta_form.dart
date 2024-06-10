import 'package:delibery_app/entidades/modelos/models/apiModels/venta_model.dart';
import 'package:delibery_app/entidades/modelos/models/providers/carrito_compras_provider.dart';
import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PagoTarjetaForm extends StatefulWidget {
  const PagoTarjetaForm({super.key});

  @override
  State<PagoTarjetaForm> createState() => _PagoTarjetaFormState();
}

DateTime now = DateTime.now();
String fechaActual =
    "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

TextEditingController _titularController = TextEditingController();
TextEditingController _mesExpiracionController = TextEditingController();
TextEditingController _anioExpiracionController = TextEditingController();
TextEditingController _numeroTarjetaController = TextEditingController();
TextEditingController _codigoController = TextEditingController();
int? id;

CarritoComprasProvider? carritoProvider;
List<Detalle> carrito = [];

void convertirCarrito() {
  for (var item in carritoProvider!.carrito) {
    carrito
        .add(Detalle(cantidad: item.cantidad, idProducto: item.producto!.id));
  }
}

getCliente() async {
  final prefs = await SharedPreferences.getInstance();
  id = prefs.getInt('usuario');
}

class _PagoTarjetaFormState extends State<PagoTarjetaForm> {
  final validar = Validadores();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCliente();
  }

  @override
  Widget build(BuildContext context) {
    carritoProvider = context.watch<CarritoComprasProvider>();
    convertirCarrito();
    return Form(
      key: _formkey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Nombre del titular",
          ),
          controller: _titularController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else {
              return null;
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Número de tarjeta",
          ),
          maxLength: 16,
          controller: _numeroTarjetaController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (validar.validarLongitudMinima(value, 16) != null) {
              return validar.validarLongitudMinima(value, 16);
            } else if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          },
        ),
        TextFormField(
          maxLength: 2,
          decoration: const InputDecoration(
            labelText: "Mes de expiración",
          ),
          controller: _mesExpiracionController,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (validar.validarLongitudMinima(value, 2) != null) {
              return validar.validarLongitudMinima(value, 2);
            } else if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          }),
        ),
        TextFormField(
          maxLength: 2,
          decoration: const InputDecoration(
            labelText: "Año de expiración",
          ),
          controller: _anioExpiracionController,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (validar.validarLongitudMinima(value, 2) != null) {
              return validar.validarLongitudMinima(value, 2);
            } else if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          }),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Código de seguridad",
          ),
          maxLength: 3,
          controller: _codigoController,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          }),
        ),
        MaterialButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              final venta = VentaModel(
                  idCliente: id ?? 0,
                  fechaCreacion: fechaActual,
                  idEstadoPago: 2,
                  idEstadoPedido: 1,
                  idRepartidor: 6,
                  idTipoPago: 1,
                  detalles: carrito);
              DeliveryService().crearVenta(venta).then((value) {
                try {
                  carritoProvider!.limpiarCarrito();
                  limpiarVariables();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pago realizado con éxito"),
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/homeclient');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error al realizar el pago"),
                    ),
                  );
                }
              });
            }
          },
          child: const Text("pagar"),
        )
      ]),
    );
  }

  void limpiarVariables() {
    _titularController.clear();
    _mesExpiracionController.clear();
    _anioExpiracionController.clear();
    _numeroTarjetaController.clear();
    _codigoController.clear();
  }
}
