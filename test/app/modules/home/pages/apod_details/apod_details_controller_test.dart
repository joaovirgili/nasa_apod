import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudwalk_nasa/app/modules/home/pages/apod_details/apod_details_controller.dart';
import 'package:cloudwalk_nasa/app/modules/home/home_module.dart';

void main() {
  initModule(HomeModule());
  ApodDetailsController apoddetails;

  setUp(() {
    apoddetails = HomeModule.to.get<ApodDetailsController>();
  });

  group('ApodDetailsController Test', () {
    test("First Test", () {
      expect(apoddetails, isInstanceOf<ApodDetailsController>());
    });
  });
}
