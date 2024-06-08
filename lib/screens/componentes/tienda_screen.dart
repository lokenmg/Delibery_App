import 'package:delibery_app/entidades/modelos/models/apiModels/tienda_model_id.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:flutter/material.dart';

class TiendaScreen extends StatefulWidget {
  const TiendaScreen({super.key});

  @override
  State<TiendaScreen> createState() => _TiendaScreenState();
}

class _TiendaScreenState extends State<TiendaScreen> {
  TiendaModelId? tiendaModelId;
  bool isLoading = true;
  String? errorMessage;

  void getStore() async {
    try {
      var response = await DeliveryService().getStore();
      print(response);
      setState(() {
        tiendaModelId = TiendaModelId.fromJson(response);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Error al cargar la información";
        isLoading = false;
      });
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : errorMessage != null
                ? Text(errorMessage!)
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                tiendaModelId!.nombre,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                tiendaModelId!.descripcion,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: Text(tiendaModelId!.telefono),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: Text(tiendaModelId!.email),
                            ),
                            ListTile(
                              leading: const Icon(Icons.schedule),
                              title: Text(tiendaModelId!.horarios),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
