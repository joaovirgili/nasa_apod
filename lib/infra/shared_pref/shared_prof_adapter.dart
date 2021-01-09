import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local_storage/local_storage_client.dart';

class SharedPrefAdapter implements ILocalStorage {
  final SharedPreferences sharedPreferences;

  SharedPrefAdapter(this.sharedPreferences);

  @override
  Future put({String key, Map<String, dynamic> data}) async {
    await sharedPreferences.setString(key, jsonEncode(data));
  }
}
