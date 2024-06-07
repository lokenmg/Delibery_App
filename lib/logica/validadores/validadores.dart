class Validadores {
  String? validarCampoVacio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un valor';
    }
    return null;
  }

  String? validarLongitudMinima(String? value, int lengt) {
    if (value == null || value.length < lengt) {
      return 'El texto debe tener al menos $lengt caracteres';
    }
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido';
    }
    return null;
  }

  String? validarEnteros(value) {
    if (value.isEmpty) return null;
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" no es un número válido';
    }
    return null;
  }

  String? validarDecimales(value) {
    if (value.isEmpty) return null;
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" no es un número válido';
    }
    return null;
  }

  //String? validar
}
