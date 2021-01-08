import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:mockito/mockito.dart';

import 'package:cloudwalk_nasa/app/modules/home/home_controller.dart';
import 'package:cloudwalk_nasa/app/modules/home/home_module.dart';
import 'package:cloudwalk_nasa/domain/usecases/fetch_apod_list_usecase.dart';

class FetchApodListUsecaseMock extends Mock implements IFetchApodListUsecase {}

void main() {
  final fetchApodListUsecaseMock = FetchApodListUsecaseMock();
  final count = 10;

  initModule(
    HomeModule(),
    changeBinds: [
      BindInject<IFetchApodListUsecase>((i) => fetchApodListUsecaseMock)
    ],
  );
  HomeController sut;

  setUp(() {
    sut = HomeModule.to.get<HomeController>();
  });

  group('HomeController Test', () {
    test("First Test", () {
      expect(sut, isInstanceOf<HomeController>());
    });

    test('Should start with loading true', () {
      expect(sut.isLoading, isTrue);
    });

    test('fetchApodList should call fetchApodListUsecase', () async {
      await sut.fetchApodList();

      verify(fetchApodListUsecaseMock(count)).called(1);
    });
  });
}
