
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static final Preferencias _instancia = new Preferencias._internal();
  factory Preferencias() {
    return _instancia;
  }
  Preferencias._internal();
  SharedPreferences _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET Y SET
  get login {
    return _prefs.getString('login') ?? '';
  }
  set login(String value) {
    _prefs.setString('login', value);
  }
}
