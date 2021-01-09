import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entities/apod_entity.dart';
import '../../../domain/usecases/fetch_apod_list_usecase.dart';
import '../../../domain/usecases/fetch_local_apod_list_usecase.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IFetchApodListUsecase _fetchApodListUsecase;
  final IFetchLocalApodListUsecase _fetchLocalApodListUsecase;
  final count = 5;

  @observable
  bool isLoading = true;

  @observable
  bool isLoadingNextPage = false;

  @observable
  bool hasError = false;

  @observable
  DateTime selectedDate;

  @observable
  String search;

  @observable
  ObservableList<ApodEntity> apodList;

  _HomeControllerBase(
    this._fetchApodListUsecase,
    this._fetchLocalApodListUsecase,
  );

  @action
  void setIsLoading(bool v) => isLoading = v;

  @action
  void setIsLoadingNextPage(bool v) => isLoadingNextPage = v;

  @action
  void setHasError(bool v) => hasError = v;

  @action
  void setApodList(List<ApodEntity> v) => apodList = v.asObservable();

  @action
  void addNextApodPage(List<ApodEntity> v) => apodList.addAll(v);

  @action
  void setSelectedDate(DateTime v) => selectedDate = v;

  @action
  void setSearch(String v) => search = v;

  Future<void> fetchApodList() async {
    setHasError(false);
    setIsLoading(true);
    try {
      final res = await _fetchApodListUsecase.call(count);
      if (res != null) {
        setApodList(res);
      }
    } catch (e) {
      setHasError(true);
    }

    setIsLoading(false);
  }

  Future fetchLocalApodList() async {
    try {
      setApodList(await _fetchLocalApodListUsecase.call());
      setIsLoading(false);
    } catch (_) {}
  }

  Future fetchApodNextPage() async {
    setIsLoadingNextPage(true);
    setHasError(false);
    try {
      addNextApodPage(await _fetchApodListUsecase.call(count));
    } catch (_) {
      setHasError(true);
    }

    await Future.delayed(const Duration(milliseconds: 500));
    setIsLoadingNextPage(false);
  }
}
