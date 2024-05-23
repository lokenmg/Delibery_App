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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nombre del producto',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Descripción del producto',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Precio del producto',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Cantidad del producto',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Imagen del producto',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showCategoriasDialog(context);
            },
            child: const Text('Seleccionar Categorías'),
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
}
