import '../../core/key.dart';
import '../../domain/entities/apod_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/repositories/apod_repository.dart';
import '../http/http_client.dart';
import '../models/apod_model.dart';

class ApodRepository implements IApodRepository {
  final IHttpClient httpClient;

  ApodRepository(this.httpClient);

  final url = "https://api.nasa.gov/planetary/apod";

  @override
  Future<ApodEntity> fetchApod() async {
    try {
      final res = await httpClient.get(
        url: url,
        queryParameters: {
          "thumbs": true,
          "api_key": nasaApiKey,
        },
      );

      return ApodModel.fromJson(res).toEntity();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }

  @override
  Future<List<ApodEntity>> fetchApodList(int count) async {
    final res = await httpClient.get(
      url: url,
      queryParameters: {
        "thumbs": true,
        "api_key": nasaApiKey,
        "count": count,
      },
    );
    return (res as List).map((e) => ApodModel.fromJson(e).toEntity()).toList();
  }
}
