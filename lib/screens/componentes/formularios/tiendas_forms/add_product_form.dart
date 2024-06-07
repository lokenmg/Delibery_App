import 'dart:io';
import 'package:delibery_app/entidades/modelos/funciones_firebase.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/categoria_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model.dart';
import 'package:delibery_app/entidades/modelos/models/image_models.dart';
import 'package:delibery_app/logica/validadores/control_imagenes.dart';
import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:flutter/material.dart';

class CategoriaModel {
  final String descripcion;
  final int idCategoria;
  bool isSelected;

  CategoriaModel({
    required this.idCategoria,
    required this.descripcion,
    this.isSelected = false,
  });
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

TextEditingController _nombreController = TextEditingController();
TextEditingController _descripcionController = TextEditingController();
TextEditingController _precioController = TextEditingController();
TextEditingController _cantidadController = TextEditingController();
TextEditingController imagenController = TextEditingController();

File? _urlFoto;
bool urlFotoCheck = false;
bool exist = false;
int? storeId;

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final validar = Validadores();
  List<CategoriaModel> categorias = [];

  List<int> categoriasSeleccionadas = [];

  void getStore() {
    final deliveryService = DeliveryService();
    deliveryService.getStore().then((value) {
      if (value['status'] != 500) {
        setState(() {
          storeId = value['idTienda'];
          exist = true;
          print("existe $exist id $storeId");
        });
      }
    });
  }

  void getCategorias() {
    DeliveryService().getCategorias().then((value) {
      setState(() {
        categoriasIdToCategoriaModel(value);
        //print(categoriasApi);
      });
    });
  }

  void categoriasIdToCategoriaModel(List<CategoriaModelId> categoriasApi) {
    categorias = categoriasApi
        .map((categoria) => CategoriaModel(
              idCategoria: categoria.idCategoria,
              descripcion: categoria.descripcion,
            ))
        .toList();
  }

  void categoriasSeleccionadasToId() {
    categoriasSeleccionadas = categorias
        .where((categoria) => categoria.isSelected)
        .map((categoria) => categoria.idCategoria)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    getStore();
    getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return exist
        ? Form(
            key: _formkey,
            child: Column(
              children: [
                _gap(),
                TextFormField(
                  controller: _nombreController,
                  decoration:
                      disenioTextFormnField("Nombre del producto", "Nombre"),
                  validator: (value) {
                    return validar.validarCampoVacio(value);
                  },
                ),
                _gap(),
                TextFormField(
                  controller: _descripcionController,
                  decoration: disenioTextFormnField(
                      "Descripción del producto", "Escibe una descripción"),
                  validator: (value) => validar.validarCampoVacio(value),
                ),
                _gap(),
                TextFormField(
                  controller: _precioController,
                  validator: (value) {
                    if (validar.validarCampoVacio(value) != null) {
                      return validar.validarCampoVacio(value);
                    } else if (validar.validarDecimales(value) != null) {
                      return validar.validarDecimales(value);
                    }
                    return null;
                  },
                  decoration:
                      disenioTextFormnField("Precio del producto", "Precio"),
                ),
                _gap(),
                TextFormField(
                  controller: _cantidadController,
                  validator: (value) {
                    if (validar.validarCampoVacio(value) != null) {
                      return validar.validarCampoVacio(value);
                    } else if (validar.validarEnteros(value) != null) {
                      return validar.validarEnteros(value);
                    }
                    return null;
                  },
                  decoration:
                      disenioTextFormnField("Cantidad disponible", "Cantidad"),
                ),
                _gap(),
                ElevatedButton(
                  onPressed: () {
                    _showCategoriasDialog(context);
                  },
                  child: const Text('Seleccionar Categorías'),
                ),
                _gap(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _urlFoto == null
                        ? Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: const Text('Imagen no seleccionada.'))
                        : Image.file(
                            _urlFoto!,
                            height: 100,
                          ),
                    const SizedBox(width: 60),
                    urlFotoCheck
                        ? const Icon(Icons.check_circle,
                            color: Colors.green, size: 50)
                        : const Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                            size: 50,
                          )
                  ],
                ),
                _gap(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ControlImagenes controlImagenes = ControlImagenes();
                        controlImagenes.seleccionarImagen().then((File? value) {
                          setState(() {
                            _urlFoto = value;
                          });
                        });
                      },
                      child: const Text('seleccionar imagen'),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    ElevatedButton(
                      onPressed: () {
                        FuncionesFirebase firebase = FuncionesFirebase();
                        firebase.uploadImage(_urlFoto!, "producto").then(
                          (ImageModel value) {
                            if (value.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(value.errorMessage!)));
                            } else {
                              print("mi url ${value.url}");
                              imagenController.text = value.url!;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Imagen subida correctamente')));
                              setState(() {
                                urlFotoCheck = true;
                              });
                            }
                          },
                        );
                      },
                      child: const Text('Subir imagen'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    categoriasSeleccionadasToId();

                    if (_formkey.currentState!.validate()) {
                      if (categoriasSeleccionadas.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Selecciona al menos una categoría')));
                      } else if (urlFotoCheck == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sube una imagen')));
                      } else {
                        final deliveryService = DeliveryService();
                        ProductoModel producto = ProductoModel(
                          nombre: _nombreController.text,
                          descripcion: _descripcionController.text,
                          precio: double.parse(_precioController.text),
                          categoriasId: categoriasSeleccionadas,
                          descuento: 0,
                          idTienda: storeId!,
                          stock: 10,
                          imagen: imagenController.text,
                        );

                        deliveryService
                            .postProducto(producto.toJson())
                            .then((value) {
                          if (value['status'] != 500) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Producto agregado')));
                            setState(() {
                              limpiarCampos();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error al agregar')));
                          }
                        });
                      }
                    }
                  },
                  child: const Text('Agregar producto'),
                ),
              ],
            ),
          )
        : const Text("No se ha registrado una tienda");
  }

  void _showCategoriasDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Selecciona Categorías'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: categorias.map((categoria) {
                    return CheckboxListTile(
                      title: Text(categoria.descripcion),
                      value: categoria.isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          categoria.isSelected = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSelectedCategories();
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSelectedCategories() {
    List<CategoriaModel> selectedCategories =
        categorias.where((categoria) => categoria.isSelected).toList();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Categorías Seleccionadas'),
          content: SingleChildScrollView(
            child: ListBody(
              children: selectedCategories.map((categoria) {
                return ListTile(
                  title: Text(categoria.descripcion),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void limpiarCampos() {
    _nombreController.clear();
    _descripcionController.clear();
    _precioController.clear();
    _cantidadController.clear();
    imagenController.clear();
    _urlFoto = null;
    urlFotoCheck = false;
    for (var categoria in categorias) {
      categoria.isSelected = false;
    }
  }

  InputDecoration disenioTextFormnField(String nLabelText, String nHintText) {
    return InputDecoration(
      labelText: nLabelText,
      hintText: nHintText,
      border: const OutlineInputBorder(),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
