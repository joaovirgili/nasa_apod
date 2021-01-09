import '../../core/constants/urls.dart';
import '../../core/key.dart';
import '../../domain/entities/apod_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/repositories/apod_repository.dart';
import '../http/http_client.dart';
import '../models/apod_model.dart';

class ApodRepository implements IApodRepository {
  final IHttpClient httpClient;

  ApodRepository(this.httpClient);

  @override
  Future<ApodEntity> fetchApod() async {
    try {
      final res = await httpClient.get(
        url: AppUrls.apod,
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
    try {
      final res = await httpClient.get(
        url: AppUrls.apod,
        queryParameters: {
          "thumbs": true,
          "api_key": nasaApiKey,
          "count": count,
        },
      );
      return (res as List)
          .map((e) => ApodModel.fromJson(e).toEntity())
          .where((e) => e.mediaType == "video" || e.mediaType == "image")
          .toList();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
