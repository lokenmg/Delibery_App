import 'package:delibery_app/entidades/modelos/models/apiModels/token_model.dart';
import 'package:flutter/material.dart';

class InfoLoginProvider extends ChangeNotifier {
  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel;

  set tokenModel(TokenModel? value) {
    _tokenModel = value;
    notifyListeners();
  }
}
