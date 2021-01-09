import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:cloudwalk_nasa/core/constants/urls.dart';
import 'package:cloudwalk_nasa/core/key.dart';
import 'package:cloudwalk_nasa/data/local_storage/local_storage_client.dart';
import 'package:cloudwalk_nasa/data/http/http_client.dart';
import 'package:cloudwalk_nasa/data/repository/apod_repository.dart';
import 'package:cloudwalk_nasa/domain/entities/apod_entity.dart';
import 'package:cloudwalk_nasa/domain/helpers/domain_error.dart';

class HttpClientMock extends Mock implements IHttpClient {}

class LocalStorageMock extends Mock implements ILocalStorage {}

void main() {
  ApodRepository sut;
  IHttpClient httpClient;
  ILocalStorage localStorage;

  setUp(() {
    httpClient = HttpClientMock();
    localStorage = LocalStorageMock();
    sut = ApodRepository(httpClient, localStorage);
  });

  group('Fetch a list of APOD', () {
    final List<Map<String, dynamic>> responseMock = [
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

    void mockSuccess() => when(httpClient.get(
          url: anyNamed("url"),
          queryParameters: anyNamed("queryParameters"),
        )).thenAnswer((realInvocation) async => Future.value(responseMock));

    final count = 10;

    test('Should call DioAdapter with correct values', () async {
      mockSuccess();

      await sut.fetchApodList(count);

      verify(httpClient.get(
        url: AppUrls.apod,
        queryParameters: {
          "thumbs": true,
          "api_key": nasaApiKey,
          "count": count,
        },
      ));

      verify(localStorage.put(key: "apod_list", data: responseMock));
    });

    test('Should return ApodEntity if HttpClient returns 200', () async {
      mockSuccess();

      final res = await sut.fetchApodList(count);

      expect(res, isA<List<ApodEntity>>());
      expect(res, isNotNull);
      expect(res, isNotEmpty);
    });

    test('Should throw Unexpected if HttpClient throws', () async {
      when(httpClient.get(
        url: anyNamed("url"),
        queryParameters: anyNamed("queryParameters"),
      )).thenThrow(Exception());

      final future = sut.fetchApodList(count);

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('Fetch a single APOD', () {
    final responseMockImage = {
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
    };

    final responseMockVideo = <String, dynamic>{
      "date": "2011-09-27",
      "explanation":
          "Have you ever dreamed of flying high above the Earth? Astronauts visiting the International Space Station do this every day, circling our restless planet twice every three hours. A dramatic example of their view was compiled in the above time-lapse video from images taken earlier this month. As the ISS speeds into the nighttime half of the globe, familiar constellations of stars remain visible above.  An aerosol haze of Earth's thin atmosphere is visible on the horizon as an thin multi-colored ring. Many wonders whiz by below, including vast banks of white clouds, large stretches of deep blue sea, land lit up by the lights of big cities and small towns, and storm clouds flashing with lightning. The video starts over the northern Pacific Ocean and then passes from western North America to western South America, ending near Antarctica as daylight finally approaches.",
      "media_type": "video",
      "service_version": "v1",
      "thumbnail_url": "https://img.youtube.com/vi/74mhQyuyELQ/0.jpg",
      "title": "Flying Over Planet Earth",
      "url": "https://www.youtube.com/embed/74mhQyuyELQ?rel=0"
    };

    void mockSuccess(Map<String, dynamic> data) => when(httpClient.get(
          url: anyNamed("url"),
          queryParameters: anyNamed("queryParameters"),
        )).thenAnswer((realInvocation) async => data);

    test('Should call DioAdapter with correct values', () async {
      mockSuccess(responseMockImage);

      await sut.fetchApod();

      verify(httpClient.get(
        url: AppUrls.apod,
        queryParameters: {
          "thumbs": true,
          "api_key": nasaApiKey,
        },
      ));
    });

    test('Should return ApodEntity if HttpClient returns 200', () async {
      mockSuccess(responseMockImage);

      final res = await sut.fetchApod();

      expect(res, isA<ApodEntity>());
      expect(res, isNotNull);
    });

    test('Should throw Unexpected if HttpClient throws', () async {
      when(httpClient.get(
        url: anyNamed("url"),
        queryParameters: anyNamed("queryParameters"),
      )).thenThrow(Exception());

      final future = sut.fetchApod();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should return a ApodEntity correctly if Apod is a video', () async {
      mockSuccess(responseMockVideo);

      final res = await sut.fetchApod();

      expect(res, isA<ApodEntity>());
      expect(res.mediaType, equals("video"));
      expect(res.thumbnailUrl, isNotNull);
      expect(res, isNotNull);
    });
  });

  group('Fetch a local list of APOD', () {
    final List<Map<String, dynamic>> dataMock = [
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

    void mockSuccess() => when(localStorage.get(key: anyNamed("key")))
        .thenAnswer((realInvocation) async => dataMock);

    test('Should call LocalStorage with correct values', () async {
      mockSuccess();

      await sut.fetchLocalApodList();

      verify(localStorage.get(key: "apod_list"));
    });

    test('Should return ApodEntity', () async {
      mockSuccess();
      final res = await sut.fetchLocalApodList();

      expect(res, isA<List<ApodEntity>>());
      expect(res, isNotNull);
      expect(res, isNotEmpty);
    });
  });
}
