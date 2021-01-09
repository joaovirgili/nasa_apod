import '../entities/apod_entity.dart';
import '../repositories/apod_repository.dart';

abstract class IFetchLocalApodListUsecase {
  Future<List<ApodEntity>> call();
}

class FetchLocalApodListUsecase implements IFetchLocalApodListUsecase {
  final IApodRepository apodRepository;

  FetchLocalApodListUsecase(this.apodRepository);

  @override
  Future<List<ApodEntity>> call() {
    return apodRepository.fetchLocalApodList();
  }
}
