import 'package:delibery_app/entidades/enums/enum_genero.dart';
import 'package:delibery_app/modelos/apis/copomex.dart';
import 'package:delibery_app/modelos/geocidong_model.dart';
import 'package:delibery_app/validadores/validadores.dart';
import 'package:flutter/material.dart';

class FormRegistroEncargado extends StatefulWidget {
  const FormRegistroEncargado({super.key});

  @override
  State<FormRegistroEncargado> createState() => _FormRegistroEncargadoState();
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

bool _vercontrasenia = true;

class _FormRegistroEncargadoState extends State<FormRegistroEncargado> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final validar = Validadores();
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
          Padding(padding: const EdgeInsets.all(3)),
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
                  _generoSeleccionado = value;
                });
              }),
          const Padding(padding: EdgeInsets.all(3)),
          const Text("Domicilio"),
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
        ],
      ),
    );
  }
}
