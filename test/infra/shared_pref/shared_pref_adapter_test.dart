import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloudwalk_nasa/data/local_storage/local_storage_client.dart';
import 'package:cloudwalk_nasa/infra/shared_pref/shared_prof_adapter.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  ILocalStorage sut;
  SharedPreferencesMock sharedPreferences;

  setUp(() async {
    sharedPreferences = SharedPreferencesMock();
    sut = SharedPrefAdapter(sharedPreferences);
  });

  test('Put Should call sharedPreferences with correct values', () async {
    final key = "key";
    final data = {"teste": "teste"};

    await sut.put(key: key, data: data);

    verify(sharedPreferences.setString(key, jsonEncode(data)));
  });

  test('Get Should call sharedPreferences with correct values', () async {
    final key = "key";

    await sut.get(key: key);

    verify(sharedPreferences.getString(key));
  });

  test('Get should return null if key has no data', () async {
    final key = "key";

    final res = await sut.get(key: key);

    expect(res, isNull);
  });
}
