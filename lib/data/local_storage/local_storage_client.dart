import 'package:meta/meta.dart';

abstract class ILocalStorage {
  Future put({
    @required String key,
    Map<String, dynamic> data,
  });
}
