import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:mockito/mockito.dart';

import 'package:cloudwalk_nasa/app/modules/home/home_controller.dart';
import 'package:cloudwalk_nasa/app/modules/home/home_module.dart';
import 'package:cloudwalk_nasa/domain/usecases/fetch_apod_list_usecase.dart';
import 'package:cloudwalk_nasa/domain/usecases/fetch_local_apod_list_usecase.dart';
import 'package:cloudwalk_nasa/domain/entities/apod_entity.dart';
import 'package:cloudwalk_nasa/domain/helpers/domain_error.dart';

class FetchApodListUsecaseMock extends Mock implements IFetchApodListUsecase {}

class FetchLocalApodListUsecaseMock extends Mock
    implements IFetchLocalApodListUsecase {}

void main() {
  final fetchApodListUsecaseMock = FetchApodListUsecaseMock();
  final fetchLocalApodListUsecaseMock = FetchLocalApodListUsecaseMock();

  initModule(
    HomeModule(),
    changeBinds: [
      BindInject<IFetchApodListUsecase>((i) => fetchApodListUsecaseMock),
      BindInject<IFetchLocalApodListUsecase>(
        (i) => fetchLocalApodListUsecaseMock,
      ),
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
      when(fetchApodListUsecaseMock(any)).thenAnswer(
        (realInvocation) async => [ApodEntity()],
      );

      await sut.fetchApodList();

      expect(sut.isLoading, isFalse);
      expect(sut.apodList, isNotEmpty);
      verify(fetchApodListUsecaseMock(sut.count)).called(1);
    });

    test('fetchLocalApodList should call fetchLocalApodListUsecase', () async {
      when(fetchLocalApodListUsecaseMock()).thenAnswer(
        (realInvocation) async => [ApodEntity()],
      );

      await sut.fetchLocalApodList();

      expect(sut.apodList, isNotEmpty);
      verify(fetchLocalApodListUsecaseMock()).called(1);
    });

    test('hasError should me true if fetchApodListUsecase throws', () async {
      when(fetchApodListUsecaseMock(any)).thenThrow(DomainError.unexpected);

      await sut.fetchApodList();

      expect(sut.hasError, isTrue);
      expect(sut.isLoading, isFalse);
    });
  });
}
