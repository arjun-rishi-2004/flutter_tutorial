import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  String _todokey = 'todo';

  Future<void> setTodo(List<Map<String, dynamic>> todo) async {
    await _storage.write(key: _todokey, value: jsonEncode(todo));
  }

  Future<List<Map<String, dynamic>>> getTodo() async {
    String? data = await _storage.read(key: _todokey);
    if (data == null || data.isEmpty) {
      return []; // Return an empty list if no data is found
    }
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    } catch (e) {
      // Handle JSON decoding error
      return []; // Return an empty list in case of error
    }
  }
}
