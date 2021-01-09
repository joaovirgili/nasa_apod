import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'apod_details_controller.g.dart';

@Injectable()
class ApodDetailsController = _ApodDetailsControllerBase
    with _$ApodDetailsController;

abstract class _ApodDetailsControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
