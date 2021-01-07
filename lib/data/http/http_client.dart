import 'package:meta/meta.dart';

abstract class IHttpClient {
  Future<Map> get({
    @required String url,
    Map<String, dynamic> queryParameters,
  });
}
