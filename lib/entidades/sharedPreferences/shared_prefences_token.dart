import 'package:delibery_app/entidades/modelos/models/apiModels/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesToken {
  static TokenModel? tokenModel;

  Future<void> saveToken(TokenModel token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token.token);
  }
}
