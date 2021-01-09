import '../../core/constants/urls.dart';
import '../../core/key.dart';
import '../../domain/entities/apod_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/repositories/apod_repository.dart';
import '../http/http_client.dart';
import '../local_storage/local_storage_client.dart';
import '../models/apod_model.dart';

class ApodRepository implements IApodRepository {
  final IHttpClient httpClient;
  final ILocalStorage localStorage;

  ApodRepository(this.httpClient, this.localStorage);

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
    bool isValidApod(ApodEntity e) =>
        (e.mediaType == "video" && e.thumbnailUrl != "") ||
        e.mediaType == "image";

    try {
      final res = await httpClient.get(
        url: AppUrls.apod,
        queryParameters: {
          "thumbs": true,
          "api_key": nasaApiKey,
          "count": count,
        },
      );
      await localStorage.put(key: "apod_list", data: res);
      return (res as List)
          .map((e) => ApodModel.fromJson(e).toEntity())
          .where((e) => isValidApod(e))
          .toList();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
