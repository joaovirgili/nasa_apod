import '../entities/apod_entity.dart';
import '../repositories/apod_repository.dart';

abstract class IFetchApodListUsecase {
  Future<List<ApodEntity>> call(int count);
}

class FetchApodListUsecase implements IFetchApodListUsecase {
  final IApodRepository apodRepository;

  FetchApodListUsecase(this.apodRepository);

  @override
  Future<List<ApodEntity>> call(int count) {
    return apodRepository.fetchApodList(count);
  }
}
