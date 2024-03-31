// To parse this JSON data, do
//
//     final discover = discoverFromJson(jsonString);

import 'dart:convert';

import 'GetTrending.dart';

Discover discoverFromJson(String str) => Discover.fromJson(json.decode(str));

String discoverToJson(Discover data) => json.encode(data.toJson());

class Discover {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  Discover({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Discover.fromJson(Map<String, dynamic> json) => Discover(
    page: json["page"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

enum OriginalLanguage {
  EN,
  PT,
  RU,
  TH
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "pt": OriginalLanguage.PT,
  "ru": OriginalLanguage.RU,
  "th": OriginalLanguage.TH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
