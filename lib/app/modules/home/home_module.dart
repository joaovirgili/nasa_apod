import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../data/http/http_client.dart';
import '../../../data/repository/apod_repository.dart';
import '../../../domain/repositories/apod_repository.dart';
import '../../../domain/usecases/fetch_apod_list_usecase.dart';
import '../../../infra/dio/dio.dart';
import 'home_controller.dart';
import 'home_page.dart';
import 'pages/apod_details/apod_details_controller.dart';
import 'pages/apod_details/apod_details_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ApodDetailsController,
        BindInject<IHttpClient>(
          (i) => DioAdapter(Dio()),
        ),
        BindInject<IApodRepository>(
          (i) => ApodRepository(i.get<IHttpClient>()),
        ),
        BindInject<IFetchApodListUsecase>(
          (i) => FetchApodListUsecase(i.get<IApodRepository>()),
        ),
        $HomeController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => ApodDetailsPage(),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
