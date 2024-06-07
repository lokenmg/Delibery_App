import 'dart:io';

import 'package:delibery_app/entidades/enums/enum_genero.dart';
import 'package:delibery_app/logica/validadores/control_imagenes.dart';
import 'package:delibery_app/entidades/modelos/apis/copomex.dart';
import 'package:delibery_app/entidades/modelos/funciones_firebase.dart';
import 'package:delibery_app/entidades/modelos/geocidong_model.dart';
import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/cliente_model.dart';
import 'package:delibery_app/entidades/modelos/models/image_models.dart';
import 'package:delibery_app/services/registros_services.dart';
import 'package:flutter/material.dart';

import '../../titulos.dart';
import '../componentes/dropdounsbuton/date_picker.dart';

class FormRegistrocliente extends StatefulWidget {
  const FormRegistrocliente({super.key});

  @override
  State<FormRegistrocliente> createState() => _FormRegistroclienteState();
}

Geocoding? _resultado;
EnumGenero? _generoSeleccionado = EnumGenero.masculino;
List<String>? _asentamientos = [];

//información personal
TextEditingController nombreController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController generoController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController telefonoController = TextEditingController();
TextEditingController fechaNacimientoController = TextEditingController();
TextEditingController urlFotoController = TextEditingController();
//domicilio
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

bool _vercontrasenia = true;

class _FormRegistroclienteState extends State<FormRegistrocliente> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final validar = Validadores();

  File? _urlFoto;

  bool urlFotoCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            _gap(),
            Title(
                color: Colors.black,
                child: const Text(
                  "Registro como encargado",
                  style: TextStyle(fontSize: 25),
                )),
            _gap(),
            TextFormField(
              decoration: disenioTextFormnField("Nombre", "Nombre completo"),
              controller: nombreController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              decoration: disenioTextFormnField("Teléfono", "Teléfono"),
              controller: telefonoController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                if (validar.validarEnteros(value) != null) {
                  return validar.validarEnteros(value);
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              decoration: disenioTextFormnField("Email", "Email"),
              controller: emailController,
              validator: (value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                if (validar.validarEmail(value) != null) {
                  return validar.validarEmail(value);
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Contraseña",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (_vercontrasenia == true) {
                            _vercontrasenia = false;
                          } else {
                            _vercontrasenia = true;
                          }
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye))),
              controller: passwordController,
              obscureText: _vercontrasenia,
              keyboardType: TextInputType.visiblePassword,
              validator: ((value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                if (validar.validarLongitudMinima(value, 6) != null) {
                  return validar.validarLongitudMinima(value, 6);
                }
                return null;
              }),
            ),
            _gap(),
            Title(color: Colors.black, child: const Text("Género")),
            _gap(),
            DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Selecciona tu género"),
                items: const [
                  DropdownMenuItem(
                    value: EnumGenero.masculino,
                    child: Text("Masculino"),
                  ),
                  DropdownMenuItem(
                    value: EnumGenero.femenino,
                    child: Text("Femenino"),
                  ),
                  DropdownMenuItem(
                    value: EnumGenero.otro,
                    child: Text("Otro"),
                  )
                ],
                value: _generoSeleccionado,
                onChanged: (EnumGenero? value) {
                  setState(() {
                    _generoSeleccionado = value;
                  });
                }),
            _gap(),
            DatePickerField(
              controller: fechaNacimientoController,
              labelText: 'Fecha de Nacimiento',
            ),
            _gap(),
            const Titulos(title: "ingresar foto de perfil"),
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
                const SizedBox(
                  width: 60,
                ),
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
                    if (_urlFoto == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Imagen no seleccionada')));
                      return;
                    }
                    firebase.uploadImage(_urlFoto!, "perfil").then(
                      (ImageModel value) {
                        if (value.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(value.errorMessage!)));
                        } else {
                          urlFotoController.text = value.url!;
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
            _gap(),
            const Titulos(title: "Dirección"),
            _gap(),
            TextFormField(
              decoration:
                  disenioTextFormnField("Código postal", "Código postal"),
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
              decoration: disenioTextFormnField("Estado", "Estado"),
              controller: estadoController,
              validator: (value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              decoration: disenioTextFormnField("Municipio", "Municipio"),
              controller: municipioController,
              validator: (value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                return null;
              },
            ),
            _gap(),
            if (_asentamientos!.isEmpty)
              const DropdownMenu(
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
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
                        inputDecorationTheme: const InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        label: const Text("Asentamiento"),
                        controller: coloniaController,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        leadingIcon: const Icon(Icons.search),
                        initialSelection: _asentamientos![0],
                        dropdownMenuEntries: _asentamientos!
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry(value: value, label: value);
                        }).toList()),
                  ],
                ),
              ),
            _gap(),
            TextFormField(
              controller: calle1Controller,
              decoration: disenioTextFormnField(
                  "Calle 1", "Escribe tu calle principal"),
            ),
            _gap(),
            TextFormField(
              controller: calle2Controller,
              decoration: disenioTextFormnField(
                  "Calle 2 (opcional)", "Escribe tu calle secundaria"),
            ),
            _gap(),
            TextFormField(
              controller: calle3Controller,
              decoration: disenioTextFormnField(
                  "Calle 3 (opcional)", "Escribe tu calle secundaria"),
            ),
            _gap(),
            TextFormField(
              controller: numeroInteriorController,
              decoration:
                  disenioTextFormnField("Número Interior", "Número interior"),
              validator: (value) {
                if (validar.validarCampoVacio(value) != null) {
                  return validar.validarCampoVacio(value);
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              controller: numeroExteriorController,
              decoration: disenioTextFormnField(
                  "Número exterior (opcional)", "Número exterior"),
            ),
            _gap(),
            TextFormField(
              controller: referenciaController,
              decoration: disenioTextFormnField("Referencia (opcional)",
                  "Escribe una referencia de tu domicilio"),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    List<String> fechaSeparada =
                        fechaNacimientoController.text.split("-");
                    ClienteModel cliente = ClienteModel(
                      nombre: nombreController.text,
                      fechaNacimiento:
                          "${fechaSeparada[2]}/${fechaSeparada[1]}/${fechaSeparada[0]}",
                      email: emailController.text,
                      telefono: telefonoController.text,
                      urlFoto: urlFotoController.text,
                      idGenero: _generoSeleccionado!.index + 1,
                      direccion: Direccion(
                        cp: int.parse(cpController.text),
                        estado: estadoController.text,
                        municipio: municipioController.text,
                        colonia: coloniaController.text,
                        calle1: calle1Controller.text,
                        calle2: calle2Controller.text,
                        calle3: calle3Controller.text,
                        referencia: referenciaController.text,
                        numeroExterior: numeroExteriorController.text,
                        numeroInterior: numeroInteriorController.text,
                      ),
                      password: passwordController.text,
                    );

                    RegistrosServices()
                        .registrarCliente(cliente.toJson())
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registro exitoso')));
                    });
                    //Navigator.pushNamed(context, "/login");
                  }
                },
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
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
