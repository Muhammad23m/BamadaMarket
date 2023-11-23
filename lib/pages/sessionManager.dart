import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _idUtilisateurKey = 'idUtilisateur';
   static const _pseudoKey = 'pseudo';
  static const _sessionTokenKey = 'sessionToken';

  final SharedPreferences _prefs;

  SessionManager(this._prefs);

  Future<void> saveUserInfo(int idUtilisateur,String pseudo,String sessionToken) async {
    await _prefs.setInt(_idUtilisateurKey, idUtilisateur);
    await _prefs.setString(_pseudoKey, pseudo);
    await _prefs.setString(_sessionTokenKey, sessionToken);
  }

  int? getidUtilisateur() {
    return _prefs.getInt(_idUtilisateurKey);
  }

  String? getSessionToken() {
    return _prefs.getString(_sessionTokenKey);
  }
 String? getPseudo() {
    return _prefs.getString(_pseudoKey);
  }

  Future<void> logout() async {
    await _prefs.remove(_idUtilisateurKey);
    await _prefs.remove(_sessionTokenKey);
  }
}