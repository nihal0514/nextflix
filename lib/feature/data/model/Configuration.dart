import 'dart:convert';

Configuration configurationFromJson(String str) => Configuration.fromJson(json.decode(str));

String configurationToJson(Configuration data) => json.encode(data.toJson());

class Configuration {
  Images? images;
  List<String>? changeKeys;

  Configuration({
    this.images,
    this.changeKeys,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    changeKeys: json["change_keys"] == null ? [] : List<String>.from(json["change_keys"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "images": images?.toJson(),
    "change_keys": changeKeys == null ? [] : List<dynamic>.from(changeKeys!.map((x) => x)),
  };
}

class Images {
  String? baseUrl;
  String? secureBaseUrl;
  List<String>? backdropSizes;
  List<String>? logoSizes;
  List<String>? posterSizes;
  List<String>? profileSizes;
  List<String>? stillSizes;

  Images({
    this.baseUrl,
    this.secureBaseUrl,
    this.backdropSizes,
    this.logoSizes,
    this.posterSizes,
    this.profileSizes,
    this.stillSizes,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    baseUrl: json["base_url"],
    secureBaseUrl: json["secure_base_url"],
    backdropSizes: json["backdrop_sizes"] == null ? [] : List<String>.from(json["backdrop_sizes"]!.map((x) => x)),
    logoSizes: json["logo_sizes"] == null ? [] : List<String>.from(json["logo_sizes"]!.map((x) => x)),
    posterSizes: json["poster_sizes"] == null ? [] : List<String>.from(json["poster_sizes"]!.map((x) => x)),
    profileSizes: json["profile_sizes"] == null ? [] : List<String>.from(json["profile_sizes"]!.map((x) => x)),
    stillSizes: json["still_sizes"] == null ? [] : List<String>.from(json["still_sizes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "base_url": baseUrl,
    "secure_base_url": secureBaseUrl,
    "backdrop_sizes": backdropSizes == null ? [] : List<dynamic>.from(backdropSizes!.map((x) => x)),
    "logo_sizes": logoSizes == null ? [] : List<dynamic>.from(logoSizes!.map((x) => x)),
    "poster_sizes": posterSizes == null ? [] : List<dynamic>.from(posterSizes!.map((x) => x)),
    "profile_sizes": profileSizes == null ? [] : List<dynamic>.from(profileSizes!.map((x) => x)),
    "still_sizes": stillSizes == null ? [] : List<dynamic>.from(stillSizes!.map((x) => x)),
  };
}

