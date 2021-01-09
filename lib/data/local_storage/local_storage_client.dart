import 'package:meta/meta.dart';

abstract class ILocalStorage {
  Future put({
    @required String key,
    @required Map<String, dynamic> data,
  });
  Future<Map<String, dynamic>> get({@required String key});
}
