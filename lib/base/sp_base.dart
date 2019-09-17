/**
 * SharedPreferences 的基类
 *
 * Create by lzx on 2019/9/11.
 */

import 'package:synchronized/synchronized.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPBase{

  static SPBase _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SPBase> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = SPBase._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SPBase._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // put object.
  static Future<bool> putObject(String key, Object value) {
    if (_prefs == null) return null;
    if (value is String) {
      return _prefs.setString(key, value);
    } else if (value is int) {
      return _prefs.setInt(key, value);
    } else if (value is bool) {
      return _prefs.setBool(key, value);
    } else if (value is double) {
      return _prefs.setDouble(key, value);
    }
    return null;
  }

  /// get object.
  static Object getObject(String key, Object defValue) {
    if (_prefs == null) return null;
    if (defValue is String) {
      return _prefs.getString(key) ?? defValue;
    } else if (defValue is int) {
      return _prefs.getInt(key) ?? defValue;
    } else if (defValue is bool) {
      return _prefs.getBool(key) ?? defValue;
    } else if (defValue is double) {
      return _prefs.getDouble(key) ?? defValue;
    }
    return null;
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {Object defValue}) {
    if (_prefs == null) return defValue;
    return _prefs.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    if (_prefs == null) return null;
    return _prefs.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    if (_prefs == null) return null;
    return _prefs.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    if (_prefs == null) return null;
    return _prefs.remove(key);
  }

  /// clear.
  static Future<bool> clear() {
    if (_prefs == null) return null;
    return _prefs.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _prefs != null;
  }
}