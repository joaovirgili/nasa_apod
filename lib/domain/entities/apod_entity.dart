class ApodEntity {
  ApodEntity({
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  final DateTime date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String title;
  final String url;
  final String thumbnailUrl;

  String get validUrl =>
      mediaType == "video" && thumbnailUrl != "" ? thumbnailUrl : url;
}
