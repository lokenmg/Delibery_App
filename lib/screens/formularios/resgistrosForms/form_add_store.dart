import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/modelos/apis/copomex.dart';
import 'package:delibery_app/modelos/geocidong_model.dart';
import 'package:delibery_app/modelos/models/apiModels/tienda_model.dart';
import 'package:delibery_app/screens/componentes/titulos.dart';
import 'package:flutter/material.dart';

class FormAddStore extends StatefulWidget {
  const FormAddStore({super.key});

  @override
  State<FormAddStore> createState() => _FormAddStoreState();
}

TextEditingController calle1Controller = TextEditingController();
TextEditingController calle2Controller = TextEditingController();
TextEditingController calle3Controller = TextEditingController();
TextEditingController coloniaController = TextEditingController();
TextEditingController cpController = TextEditingController();
TextEditingController estadoController = TextEditingController();
TextEditingController municipioController = TextEditingController();
TextEditingController numeroExteriorController = TextEditingController();
TextEditingController numeroInteriorController = TextEditingController();
TextEditingController referenciaController = TextEditingController();

//info tienda
TextEditingController nombreController = TextEditingController();
TextEditingController telefonoController = TextEditingController();
TextEditingController calificacionController = TextEditingController();
TextEditingController descripccionController = TextEditingController();
TextEditingController horarioController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _FormAddStoreState extends State<FormAddStore> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Geocoding? _resultado;
  List<String>? _asentamientos = [];
  final validar = Validadores();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nombre del negocio",
            ),
            controller: nombreController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Descripción del negocio",
            ),
            controller: descripccionController,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Teléfono",
            ),
            controller: telefonoController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Email",
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              } else if (validar.validarEmail(value) != null) {
                return validar.validarEmail(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: horarioController,
            decoration: const InputDecoration(
              labelText: "Horario",
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(15)),
          const Titulos(title: "Dirección"),
          const Padding(padding: EdgeInsets.all(3)),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(labelText: "Código Postal"),
            controller: cpController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            onChanged: (value) {
              PeticionesCopomex cp = PeticionesCopomex();
              if (value.length == 5) {
                cp.getCpGeoEncoding(value).then((Geocoding value) {
                  setState(() {
                    _resultado = value;
                    estadoController.text = _resultado!.response.estado;
                    municipioController.text = _resultado!.response.municipio;
                    _asentamientos = _resultado!.response.asentamiento;
                  });
                });
              }
            },
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(labelText: "Estado"),
            controller: estadoController,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(labelText: "Municipio"),
            controller: municipioController,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(6)),
          if (_asentamientos!.isEmpty)
            const DropdownMenu(
              initialSelection: Text("Asentamiento"),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: Text("Asentamiento"), label: "algo")
              ],
            ),
          if (_asentamientos!.isNotEmpty)
            SingleChildScrollView(
              child: Column(
                children: [
                  DropdownMenu<String>(
                      label: const Text("Asentamiento"),
                      controller: coloniaController,
                      enableFilter: true,
                      requestFocusOnTap: true,
                      leadingIcon: const Icon(Icons.search),
                      initialSelection: "",
                      dropdownMenuEntries: _asentamientos!
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList()),
                ],
              ),
            ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: calle1Controller,
            decoration: const InputDecoration(labelText: "Calle 1"),
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: calle2Controller,
            decoration: const InputDecoration(labelText: "Calle 2"),
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: calle3Controller,
            decoration: const InputDecoration(labelText: "Calle 3"),
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: numeroInteriorController,
            decoration: const InputDecoration(labelText: "Número interior"),
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: numeroExteriorController,
            decoration: const InputDecoration(labelText: "Número exterior"),
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: referenciaController,
            decoration: const InputDecoration(labelText: "Referencia"),
          ),
          const Padding(padding: EdgeInsets.all(3)),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  TiendaModel nuevaTienda = TiendaModel(
                      calificacion: 5,
                      descripcion: descripccionController.text,
                      direccion: Direccion(
                          calle1: calle1Controller.text,
                          calle2: calle2Controller.text,
                          calle3: calle3Controller.text,
                          colonia: coloniaController.text,
                          cp: int.parse(cpController.text),
                          estado: estadoController.text,
                          municipio: municipioController.text,
                          numeroExterior: numeroExteriorController.text,
                          numeroInterior: numeroInteriorController.text,
                          referencia: referenciaController.text),
                      email: emailController.text,
                      horarios: horarioController.text,
                      nombre: nombreController.text,
                      telefono: telefonoController.text);
                }
              },
              child: const Text("Registrar"),
            ),
          )
        ],
      ),
    );
  }
}
