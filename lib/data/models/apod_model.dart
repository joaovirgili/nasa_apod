import 'dart:convert';

import '../../domain/entities/apod_entity.dart';

ApodModel apodModelFromJson(String str) => ApodModel.fromJson(json.decode(str));

String apodModelToJson(ApodModel data) => json.encode(data.toJson());

class ApodModel {
  ApodModel({
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  final DateTime date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  final String thumbnailUrl;

  factory ApodModel.fromJson(Map<dynamic, dynamic> json) => ApodModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        explanation: json["explanation"] == null ? null : json["explanation"],
        hdurl: json["hdurl"] == null ? null : json["hdurl"],
        mediaType: json["media_type"] == null ? null : json["media_type"],
        serviceVersion:
            json["service_version"] == null ? null : json["service_version"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        thumbnailUrl:
            json["thumbnail_url"] == null ? null : json["thumbnail_url"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation == null ? null : explanation,
        "hdurl": hdurl == null ? null : hdurl,
        "media_type": mediaType == null ? null : mediaType,
        "service_version": serviceVersion == null ? null : serviceVersion,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "thumbnail_url": thumbnailUrl == null ? null : thumbnailUrl,
      };

  ApodEntity toEntity() => ApodEntity(
        date: date,
        explanation: explanation,
        hdurl: hdurl,
        mediaType: mediaType,
        title: title,
        url: url,
        thumbnailUrl: thumbnailUrl,
      );
}
