import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloudwalk_nasa/data/local_storage/local_storage_client.dart';
import 'package:cloudwalk_nasa/infra/shared_pref/shared_prof_adapter.dart';

void main() {
  final validKey = "validKey";
  final validData = {"teste": "teste"};
  SharedPreferences.setMockInitialValues({validKey: jsonEncode(validData)});
  ILocalStorage sut;

  setUp(() async {
    sut = SharedPrefAdapter();
  });

  test('Get should return null if key has no data', () async {
    final key = "key";

    final res = await sut.get(key: key);

    expect(res, isNull);
  });

  test('Get should return Map if key has data', () async {
    final data = await sut.get(key: validKey);

    expect(data, equals(validData));
  });
}
