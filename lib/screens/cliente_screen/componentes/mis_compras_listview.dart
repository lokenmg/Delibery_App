import 'package:delibery_app/entidades/modelos/models/apiModels/estado_pago_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/estado_pedido.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/tipo_pago_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/venta_completa_model.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:flutter/material.dart';

class MisComprasListView extends StatefulWidget {
  const MisComprasListView({super.key});

  @override
  State<MisComprasListView> createState() => _MisComprasListViewState();
}

class _MisComprasListViewState extends State<MisComprasListView> {
  List<VentaCompletaModel> ventas = [];
  bool isLoading = true;
  bool error = false;

  void getCompras() async {
    try {
      List<VentaCompletaModel> fetchedVentas =
          await DeliveryService().getVentasByIdCliente();
      setState(() {
        ventas = fetchedVentas;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCompras();
  }

  @override
  Widget build(BuildContext context) {
    return error
        ? const Center(
            child: Text('Error al cargar las compras'),
          )
        : isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ventas.isEmpty
                ? const Center(
                    child: Text('No hay compras'),
                  )
                : ListView.builder(
                    itemCount: ventas.length,
                    itemBuilder: (context, index) {
                      VentaCompletaModel venta = ventas[index];
                      return Card(
                        child: ExpansionTile(
                          title: Text('Compra: ${venta.fechaCreacion}'),
                          children: <Widget>[
                            getTipoPagoModel(venta),
                            getEstadoPagoModel(venta),
                            getEstadoPedidoModel(venta),
                            getTotal(venta.detalles),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: venta.detalles.length,
                              itemBuilder: (context, detalleIndex) {
                                Detalle detalle = venta.detalles[detalleIndex];
                                return ExpansionTile(
                                  title: Text(
                                      'Producto: ${detalle.nombre} - ${subtotal(detalle)}'),
                                  children: <Widget>[
                                    Text('Cantidad: ${detalle.cantidad}'),
                                    Text('Descuento: ${detalle.descuento}'),
                                    Image.network(detalle.imagen),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
  }

  getTotal(List<Detalle> detalles) {
    double total = 0;
    for (var detalle in detalles) {
      total += detalle.precio * detalle.cantidad;
    }
    return Text('Total: \$$total');
  }

  subtotal(Detalle detalle) =>
      'Subtotal: \$${detalle.precio * detalle.cantidad}';

  FutureBuilder<EstadoPagoModel> getEstadoPagoModel(VentaCompletaModel venta) {
    return FutureBuilder<EstadoPagoModel>(
      future: DeliveryService().getEstadoPagoById(venta.idEstadoPago),
      builder: (BuildContext context, AsyncSnapshot<EstadoPagoModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Estado de Pago: ${snapshot.data!.descripcion}');
        }
      },
    );
  }

  FutureBuilder<EstadoPedidoModel> getEstadoPedidoModel(
      VentaCompletaModel venta) {
    return FutureBuilder<EstadoPedidoModel>(
      future: DeliveryService().getEstadoPedidoById(venta.idEstadoPago),
      builder:
          (BuildContext context, AsyncSnapshot<EstadoPedidoModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Estado de Pedido: ${snapshot.data!.descripcion}');
        }
      },
    );
  }

  FutureBuilder<TipoPagoModel> getTipoPagoModel(VentaCompletaModel venta) {
    return FutureBuilder<TipoPagoModel>(
      future: DeliveryService().getTipoPagoById(venta.idEstadoPago),
      builder: (BuildContext context, AsyncSnapshot<TipoPagoModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Tipo de Pago: ${snapshot.data!.descripcion}');
        }
      },
    );
  }
}
