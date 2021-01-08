import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entities/apod_entity.dart';
import '../../../domain/usecases/fetch_apod_list_usecase.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IFetchApodListUsecase _fetchApodListUsecase;
  final count = 10;

  @observable
  bool isLoading = true;

  @observable
  bool hasError = false;

  @observable
  ObservableList<ApodEntity> apodList;

  _HomeControllerBase(this._fetchApodListUsecase);

  @action
  void setIsLoading(bool v) => isLoading = v;

  @action
  void setHasError(bool v) => hasError = v;

  @action
  void setApodList(List<ApodEntity> v) => apodList = v.asObservable();

  Future<void> fetchApodList() async {
    setHasError(false);
    try {
      setApodList(await _fetchApodListUsecase.call(count));
    } catch (e) {
      setHasError(true);
    }

    setIsLoading(false);
  }
}
