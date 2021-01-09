import '../entities/apod_entity.dart';

abstract class IApodRepository {
  Future<ApodEntity> fetchApod();
  Future<List<ApodEntity>> fetchApodList(int count);
  Future<List<ApodEntity>> fetchLocalApodList();
}
