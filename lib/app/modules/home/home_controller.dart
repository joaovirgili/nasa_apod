import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/usecases/fetch_apod_list_usecase.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IFetchApodListUsecase _fetchApodListUsecase;
  final count = 10;

  @observable
  bool isLoading = true;

  _HomeControllerBase(this._fetchApodListUsecase);

  Future<void> fetchApodList() async {
    await _fetchApodListUsecase(count);
  }
}
