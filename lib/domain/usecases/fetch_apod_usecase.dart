import '../entities/apod_entity.dart';
import '../repositories/apod_repository.dart';

abstract class IFetchApodUsecase {
  Future<ApodEntity> call();
}

class FetchApodUsecase implements IFetchApodUsecase {
  final IApodRepository apodRepository;

  FetchApodUsecase(this.apodRepository);
  @override
  Future<ApodEntity> call() => apodRepository.fetchApod();
}
