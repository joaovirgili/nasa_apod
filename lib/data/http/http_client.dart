import 'package:meta/meta.dart';

abstract class IHttpClient {
  Future<dynamic> get({
    @required String url,
    Map<String, dynamic> queryParameters,
  });
}
