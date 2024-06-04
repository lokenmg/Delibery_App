import 'dart:io';

import 'package:delibery_app/entidades/modelos/funciones_firebase.dart';
import 'package:delibery_app/entidades/modelos/models/image_models.dart';
import 'package:delibery_app/logica/validadores/control_imagenes.dart';
import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:flutter/material.dart';

class CategoriaModel {
  final String descripcion;
  bool isSelected;

  CategoriaModel({
    required this.descripcion,
    this.isSelected = false,
  });
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  List<CategoriaModel> categorias = [
    CategoriaModel(descripcion: 'Tecnología'),
    CategoriaModel(descripcion: 'Ciencia'),
    CategoriaModel(descripcion: 'Arte'),
    CategoriaModel(descripcion: 'Deportes'),
    CategoriaModel(descripcion: 'Historia'),
    CategoriaModel(descripcion: 'Literatura'),
  ];
  File? _urlFoto;
  bool urlFotoCheck = false;

  final validar = Validadores();
  @override
  Widget build(BuildContext context) {
    /*TextEditingController _nombreController = TextEditingController();
    TextEditingController _descripcionController = TextEditingController();
    TextEditingController _precioController = TextEditingController();
    TextEditingController _cantidadController = TextEditingController();
    TextEditingController _categoriaController = TextEditingController();
    */
    TextEditingController imagenController = TextEditingController();

    return Form(
      child: Column(
        children: [
          _gap(),
          TextFormField(
            decoration: disenioTextFormnField("Nombre del producto", "Nombre"),
            validator: (value) {
              return validar.validarCampoVacio(value);
            },
          ),
          _gap(),
          TextFormField(
            decoration: disenioTextFormnField(
                "Descripción del producto", "Escibe una descripción"),
            validator: (value) => validar.validarCampoVacio(value),
          ),
          _gap(),
          TextFormField(
            decoration: disenioTextFormnField("Precio del producto", "Precio"),
          ),
          _gap(),
          TextFormField(
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
                        imagenController.text = value.url!;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Imagen subida correctamente')));
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
              // Aquí puedes agregar la lógica para manejar la adición del producto
              // incluyendo las categorías seleccionadas.
            },
            child: const Text('Agregar producto'),
          ),
        ],
      ),
    );
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

  InputDecoration disenioTextFormnField(String nLabelText, String nHintText) {
    return InputDecoration(
      labelText: nLabelText,
      hintText: nHintText,
      border: const OutlineInputBorder(),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
