import 'dart:io';

import 'package:delibery_app/entidades/enums/enum_genero.dart';
import 'package:delibery_app/logica/validadores/control_imagenes.dart';
import 'package:delibery_app/modelos/apis/copomex.dart';
import 'package:delibery_app/modelos/funciones_firebase.dart';
import 'package:delibery_app/modelos/geocidong_model.dart';
import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/modelos/models/image_models.dart';
import 'package:delibery_app/services/registros_services.dart';
import 'package:flutter/material.dart';

import '../../../../modelos/models/apiModels/repartidor_model.dart';
import '../../titulos.dart';
import '../componentes/dropdounsbuton/date_picker.dart';

class FormRegistroRepartidor extends StatefulWidget {
  const FormRegistroRepartidor({super.key});

  @override
  State<FormRegistroRepartidor> createState() => _FormRegistroRepartidorState();
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
//documentos
TextEditingController curpController = TextEditingController();
TextEditingController ineController = TextEditingController();
TextEditingController antecedentesController = TextEditingController();
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

//automovil

TextEditingController licenciaController = TextEditingController();
TextEditingController placaController = TextEditingController();
TextEditingController marcaController = TextEditingController();
TextEditingController tipoController = TextEditingController();
TextEditingController modeloController = TextEditingController();
TextEditingController repuveController = TextEditingController();
TextEditingController nivController = TextEditingController();
bool _vercontrasenia = true;

class _FormRegistroRepartidorState extends State<FormRegistroRepartidor> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final validar = Validadores();

  File? _curp;
  File? _ine;
  File? _antecedentes;
  File? _urlFoto;
  File? _licencia;
  File? _repuve;

  bool curpCheck = false;
  bool ineCheck = false;
  bool antecedentesCheck = false;
  bool urlFotoCheck = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Title(
              color: Colors.black,
              child: const Text(
                "Registro como encargado",
                style: TextStyle(fontSize: 25),
              )),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nombre",
            ),
            controller: nombreController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Teléfono"),
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
          const Padding(padding: EdgeInsets.all(3)),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: const InputDecoration(labelText: "Email"),
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
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            decoration: InputDecoration(
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
          const Padding(padding: EdgeInsets.all(3)),
          Title(color: Colors.black, child: const Text("Género")),
          DropdownButton(
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
                  if (value != null) {
                    _generoSeleccionado = value;
                  }
                });
              }),
          const Padding(padding: EdgeInsets.all(3)),
          DatePickerField(
            controller: fechaNacimientoController,
            labelText: 'Fecha de Nacimiento',
          ),
          const Padding(padding: EdgeInsets.all(3)),
          const Titulos(title: "ingresar foto de perfil"),
          Row(
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
                  if (_urlFoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Imagen no seleccionada')));
                    return;
                  }
                  FuncionesFirebase firebase = FuncionesFirebase();
                  firebase.uploadImage(_urlFoto!, "perfil").then(
                    (ImageModel value) {
                      if (value.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.errorMessage!)));
                      } else {
                        urlFotoController.text = value.url!;
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
          const Padding(padding: EdgeInsets.all(3)),
          const Titulos(title: "Dirección"),
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
          const Padding(padding: EdgeInsets.all(3)),
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
                      initialSelection: _asentamientos![0],
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
          const Titulos(title: "Documentos"),
          const Padding(padding: EdgeInsets.all(3)),
          const Titulos(title: "ingresar foto su curp"),
          Row(
            children: [
              _curp == null
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: const Text('Imagen no seleccionada.'))
                  : Image.file(
                      _curp!,
                      height: 100,
                    ),
              curpCheck
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 50)
                  : const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 50,
                    )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ControlImagenes controlImagenes = ControlImagenes();
                  controlImagenes.seleccionarImagen().then((File? value) {
                    setState(() {
                      _curp = value;
                    });
                  });
                },
                child: const Text('seleccionar imagen'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  if (_urlFoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Imagen no seleccionada')));
                    return;
                  }
                  FuncionesFirebase firebase = FuncionesFirebase();
                  firebase.uploadImage(_curp!, "curp").then(
                    (ImageModel value) {
                      if (value.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.errorMessage!)));
                      } else {
                        curpController.text = value.url!;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Imagen subida correctamente')));
                        setState(() {
                          curpCheck = true;
                        });
                      }
                    },
                  );
                },
                child: const Text('Subir imagen'),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(3)),
          const Titulos(title: "Ingresar foto de su INE"),
          const Padding(padding: EdgeInsets.all(3)),
          Row(
            children: [
              _ine == null
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: const Text('Imagen no seleccionada.'))
                  : Image.file(
                      _ine!,
                      height: 100,
                    ),
              ineCheck
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 50)
                  : const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 50,
                    )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ControlImagenes controlImagenes = ControlImagenes();
                  controlImagenes.seleccionarImagen().then((File? value) {
                    setState(() {
                      _ine = value;
                    });
                  });
                },
                child: const Text('Seleccionar imagen'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  if (_urlFoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Imagen no seleccionada')));
                    return;
                  }
                  FuncionesFirebase firebase = FuncionesFirebase();
                  firebase.uploadImage(_ine!, "ine").then(
                    (ImageModel value) {
                      if (value.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.errorMessage!)));
                      } else {
                        ineController.text = value.url!;
                        setState(() {
                          ineCheck = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Imagen subida correctamente')));
                      }
                    },
                  );
                },
                child: const Text('Subir imagen'),
              ),
            ],
          ),
          const Titulos(
              title:
                  "Ingresar foto de su Documento de antecedentes no penales"),
          Row(
            children: [
              _antecedentes == null
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: const Text('Imagen no seleccionada.'))
                  : Image.file(
                      _antecedentes!,
                      height: 100,
                    ),
              antecedentesCheck
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 50)
                  : const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 50,
                    )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ControlImagenes controlImagenes = ControlImagenes();
                  controlImagenes.seleccionarImagen().then((File? value) {
                    setState(() {
                      _antecedentes = value;
                    });
                  });
                },
                child: const Text('Seleccionar imagen'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  if (_urlFoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Imagen no seleccionada')));
                    return;
                  }
                  FuncionesFirebase firebase = FuncionesFirebase();
                  firebase.uploadImage(_antecedentes!, "Antecedentes").then(
                    (ImageModel value) {
                      if (value.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.errorMessage!)));
                      } else {
                        antecedentesController.text = value.url!;
                        setState(() {
                          antecedentesCheck = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Imagen subida correctamente')));
                      }
                    },
                  );
                },
                child: const Text('Subir imagen'),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(3)),
          const Titulos(title: "información del automovil"),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: tipoController,
            decoration: const InputDecoration(labelText: "Tipo"),
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: modeloController,
            decoration: const InputDecoration(labelText: "Modelo"),
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: marcaController,
            decoration: const InputDecoration(labelText: "Marca"),
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: placaController,
            decoration: const InputDecoration(labelText: "Placa"),
            maxLength: 7,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          TextFormField(
            controller: nivController,
            decoration: const InputDecoration(labelText: "NIV"),
            maxLength: 17,
            validator: (value) {
              if (validar.validarCampoVacio(value) != null) {
                return validar.validarCampoVacio(value);
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(3)),
          const Titulos(title: "Ingresar foto de su Repuve"),
          Row(
            children: [
              _repuve == null
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: const Text('Imagen no seleccionada.'))
                  : Image.file(
                      _repuve!,
                      height: 100,
                    ),
              antecedentesCheck
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 50)
                  : const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 50,
                    )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ControlImagenes controlImagenes = ControlImagenes();
                  controlImagenes.seleccionarImagen().then((File? value) {
                    setState(() {
                      _repuve = value;
                    });
                  });
                },
                child: const Text('Seleccionar imagen'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  if (_urlFoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Imagen no seleccionada')));
                    return;
                  }
                  FuncionesFirebase firebase = FuncionesFirebase();
                  firebase.uploadImage(_repuve!, "Repuve").then(
                    (ImageModel value) {
                      if (value.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.errorMessage!)));
                      } else {
                        repuveController.text = value.url!;
                        setState(() {
                          antecedentesCheck = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Imagen subida correctamente')));
                      }
                    },
                  );
                },
                child: const Text('Subir imagen'),
              ),
            ],
          ),
          const Titulos(title: "Ingresar foto de su Licencia"),
          Row(
            children: [
              _licencia == null
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: const Text('Imagen no seleccionada.'))
                  : Image.file(
                      _licencia!,
                      height: 100,
                    ),
              antecedentesCheck
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 50)
                  : const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 50,
                    )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ControlImagenes controlImagenes = ControlImagenes();
                  controlImagenes.seleccionarImagen().then((File? value) {
                    setState(() {
                      _licencia = value;
                    });
                  });
                },
                child: const Text('Seleccionar imagen'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  if (_urlFoto == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Imagen no seleccionada')));
                    return;
                  }
                  FuncionesFirebase firebase = FuncionesFirebase();
                  firebase.uploadImage(_licencia!, "Licencia").then(
                    (ImageModel value) {
                      if (value.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.errorMessage!)));
                      } else {
                        licenciaController.text = value.url!;
                        setState(() {
                          antecedentesCheck = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Imagen subida correctamente')));
                      }
                    },
                  );
                },
                child: const Text('Subir imagen'),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(3)),
          MaterialButton(
              onPressed: () {
                List<String> fechaSeparada =
                    fechaNacimientoController.text.split("-");
                if (_formkey.currentState!.validate()) {
                  RepartidorModel repartidorModel = RepartidorModel(
                      antecedentes: antecedentesController.text,
                      curp: curpController.text,
                      email: emailController.text,
                      fechaNacimiento:
                          "${fechaSeparada[2]}/${fechaSeparada[1]}/${fechaSeparada[0]}",
                      idGenero: _generoSeleccionado!.index + 1,
                      ine: ineController.text,
                      nombre: nombreController.text,
                      password: passwordController.text,
                      telefono: telefonoController.text,
                      licencia: licenciaController.text,
                      vehiculo: Vehiculo(
                          marca: marcaController.text,
                          modelo: modeloController.text,
                          niv: nivController.text,
                          placa: placaController.text,
                          repube: repuveController.text,
                          tipo: tipoController.text),
                      direccion: Direccion(
                        cp: int.parse(cpController.text),
                        municipio: municipioController.text,
                        colonia: coloniaController.text,
                        estado: estadoController.text,
                        calle1: calle1Controller.text,
                        calle2: calle2Controller.text,
                        calle3: calle3Controller.text,
                        numeroExterior: numeroExteriorController.text,
                        numeroInterior: numeroInteriorController.text,
                        referencia: referenciaController.text,
                      ));

                  RegistrosServices()
                      .registrarEncargado(repartidorModel.toJson())
                      .then((value) => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text('Registro exitoso'))));
                  Navigator.pushNamed(context, "/login");
                }
              },
              child: const Text("Registrar"))
        ],
      ),
    );
  }
}
