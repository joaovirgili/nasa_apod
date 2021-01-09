import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local_storage/local_storage_client.dart';

class SharedPrefAdapter implements ILocalStorage {
  @override
  Future put({
    @required String key,
    @required dynamic data,
  }) async {
    await (await SharedPreferences.getInstance())
        .setString(key, jsonEncode(data));
  }

  @override
  Future<Map<String, dynamic>> get({@required String key}) async {
    final res = (await SharedPreferences.getInstance()).getString(key);

    return res == null ? null : jsonDecode(res);
  }
}
