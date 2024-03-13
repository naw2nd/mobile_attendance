import 'dart:developer';

import 'package:mobile_attendance/package_handler/local_storage/domain/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl implements LocalStorage {
  SharedPreferences? prefs;

  final _storageErrorNameLog = 'Storage Error';

  @override
  Future fetch({required String key}) async {
    try {
      return (await _prefs).get(key);
    } catch (e) {
      log(e.toString(), name: _storageErrorNameLog);
      throw Exception(
          'Terjadi kesalahan saat mengambil data dari penyimpanan lokal');
    }
  }

  @override
  Future store({required String key, required value}) async {
    try {
      switch (value.runtimeType) {
        case const (String):
          await prefs?.setString(key, value);
          break;
        case const (int):
          await prefs?.setInt(key, value);
          break;
        case const (bool):
          await prefs?.setBool(key, value);
          break;
        case const (double):
          await prefs?.setDouble(key, value);
          break;
        case const (List<String>):
          await prefs?.setStringList(key, value);
          break;
        default:
          await prefs?.setString(key, value.toString());
          break;
      }
    } catch (e) {
      log(e.toString(), name: _storageErrorNameLog);
      throw Exception(
          'Terjadi kesalahan saat menyimpan data ke penyimpanan lokal');
    }
  }

  @override
  Future remove({required String key}) async {
    try {
      return (await _prefs).remove(key);
    } catch (e) {
      log(e.toString(), name: _storageErrorNameLog);
      throw Exception(
          'Terjadi kesalahan saat menghapus data di penyimpanan lokal');
    }
  }

  Future<SharedPreferences> get _prefs async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }
}
