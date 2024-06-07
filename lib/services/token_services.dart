import 'package:shared_preferences/shared_preferences.dart';

class TokenServices {
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('usuario');
  }

  static Future<void> setUsuario(int usuario) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('usuario', usuario);
  }

  static Future<int?> getUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('usuario');
  }
}
