import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local_storage/local_storage_client.dart';

class SharedPrefAdapter implements ILocalStorage {
  final SharedPreferences sharedPreferences;

  SharedPrefAdapter(this.sharedPreferences);

  @override
  Future put({
    @required String key,
    @required Map<String, dynamic> data,
  }) async {
    await sharedPreferences.setString(key, jsonEncode(data));
  }

  @override
  Future<Map<String, dynamic>> get({@required String key}) {
    final res = sharedPreferences.getString(key);

    return res == null ? null : jsonDecode(res);
  }
}
