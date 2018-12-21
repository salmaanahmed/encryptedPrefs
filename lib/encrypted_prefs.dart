library smooth_star_rating;

import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class EncryptedPrefs {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> generateRandomKey() =>
      new PlatformStringCryptor().generateRandomKey();

  Future<String> encryptString(String string, String key) async =>
      new PlatformStringCryptor().encrypt(string, key);

  Future<String> decryptString(String string, String key) async =>
      new PlatformStringCryptor().decrypt(string, key);

  set(String key, Object value, String encryptionKey) async {
    final prefs = await _prefs;
    String object = json.encode(value);
    String encryptedObject = await encryptString(object, encryptionKey);
    prefs.setString(key, encryptedObject);
  }

  Future<Object> get(String key, String encryptionKey, Function func) async {
    final prefs = await _prefs;
    String encryptedObject = prefs.getString(key);
    String jsonString = await decryptString(encryptedObject, encryptionKey);
    Object value = func(json.decode(jsonString));
    return value;
  }
}
