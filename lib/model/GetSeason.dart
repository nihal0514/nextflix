import 'dart:convert';

GetSeason getSeasonFromJson(String str) => GetSeason.fromJson(json.decode(str));

String getSeasonToJson(GetSeason data) => json.encode(data.toJson());

class GetSeason {
  String? id;
  DateTime? airDate;
  List<Episode>? episodes;
  String? name;
  String? overview;
  int? getSeasonId;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  GetSeason({
    this.id,
    this.airDate,
    this.episodes,
    this.name,
    this.overview,
    this.getSeasonId,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory GetSeason.fromJson(Map<String, dynamic> json) => GetSeason(
    id: json["_id"],
    airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
    episodes: json["episodes"] == null ? [] : List<Episode>.from(json["episodes"]!.map((x) => Episode.fromJson(x))),
    name: json["name"],
    overview: json["overview"],
    getSeasonId: json["id"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: json["vote_average"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "air_date": "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
    "episodes": episodes == null ? [] : List<dynamic>.from(episodes!.map((x) => x.toJson())),
    "name": name,
    "overview": overview,
    "id": getSeasonId,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "vote_average": voteAverage,
  };
}

class Episode {
  DateTime? airDate;
  int? episodeNumber;
  String? episodeType;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  dynamic stillPath;
  double? voteAverage;
  int? voteCount;
  List<dynamic>? crew;
  List<dynamic>? guestStars;

  Episode({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.crew,
    this.guestStars,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
    episodeNumber: json["episode_number"],
    episodeType: json["episode_type"]!,
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    productionCode: json["production_code"],
    runtime: json["runtime"],
    seasonNumber: json["season_number"],
    showId: json["show_id"],
    stillPath: json["still_path"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
    crew: json["crew"] == null ? [] : List<dynamic>.from(json["crew"]!.map((x) => x)),
    guestStars: json["guest_stars"] == null ? [] : List<dynamic>.from(json["guest_stars"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "air_date": "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "episode_type":episodeType,
    "id": id,
    "name": name,
    "overview": overview,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x)),
    "guest_stars": guestStars == null ? [] : List<dynamic>.from(guestStars!.map((x) => x)),
  };
}



