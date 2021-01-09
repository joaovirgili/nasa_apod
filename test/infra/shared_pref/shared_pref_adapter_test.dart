import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloudwalk_nasa/data/local_storage/local_storage_client.dart';
import 'package:cloudwalk_nasa/infra/shared_pref/shared_prof_adapter.dart';

void main() {
  final validKey = "validKey";
  final validData = [
    {
      "date": "2021-01-06",
      "explanation":
          "Why are these sand dunes on Mars striped?  No one is sure.  The featured image shows striped dunes in Kunowsky Crater on Mars, photographed recently with the Mars Reconnaissance Orbiter’s HiRISE Camera.  Many Martian dunes are known to be covered unevenly with carbon dioxide (dry ice) frost, creating patterns of light and dark areas.  Carbon dioxide doesn’t melt, but sublimates, turning directly into a gas. Carbon dioxide is also a greenhouse material even as a solid, so it can trap heat under the ice and sublimate from the bottom up, causing geyser-like eruptions.  During Martian spring, these eruptions can cause a pattern of dark defrosting spots, where the darker sand is exposed.  The featured image, though, was taken during Martian autumn, when the weather is getting colder – making these stripes particularly puzzling.  One hypothesis is that they are caused by cracks in the ice that form from weaker eruptions or thermal stress as part of the day-night cycle, but research continues.  Watching these dunes and others through more Martian seasons may give us more clues to solve this mystery.",
      "hdurl":
          "https://apod.nasa.gov/apod/image/2101/StripedDunes_HiRISE_1182.jpg",
      "media_type": "image",
      "service_version": "v1",
      "title": "Striped Sand Dunes on Mars",
      "url":
          "https://apod.nasa.gov/apod/image/2101/StripedDunes_HiRISE_1080.jpg"
    }
  ];
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

  test('Get should return validData if key has data', () async {
    final data = await sut.get(key: validKey);

    expect(data, equals(validData));
  });
}
