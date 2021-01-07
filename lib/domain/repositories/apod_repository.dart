import '../entities/apod_entity.dart';

abstract class IApodRepository {
  Future<ApodEntity> fetchApod();
}
