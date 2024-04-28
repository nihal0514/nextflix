import 'dart:convert';

import 'package:nextflix/feature/domain/repository/Repository.dart';
import 'package:http/http.dart' as http;

import '../../../config/api/api.dart';
import '../model/Configuration.dart';
import '../model/Discover.dart';
import '../model/GetImage.dart';
import '../model/GetSeason.dart';
import '../model/GetTrending.dart';
import '../model/Search.dart';


class RepositoryImpl extends Repository {
  String endpoint = Api.endpoint;
  String apiKey = Api.apiKey;


  @override
  Future<dynamic> getTrending({type = 'all', time = 'week'}) async {

    var response = await http.get(Uri.parse('$endpoint/trending/$type/$time?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= trendingFromJson(response.body);
      return data.results;
    }
    return [];
  }

  @override
  Future<dynamic> getDiscover(type) async {

    var response = await http.get(Uri.parse('$endpoint/discover/$type?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= discoverFromJson(response.body);
      return data.results;
    }
    return [];
  }

  @override
  Future<Configuration?> getConfiguration() async {

    var response = await http.get(Uri.parse('$endpoint/configuration?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= configurationFromJson(response.body);
      return data;
    }
    return null;
  }

  @override
  Future<GetImages?> getImages(id, type) async {

    var response = await http.get(Uri.parse('$endpoint/$type/$id/images?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= getImagesFromJson(response.body);
      return data;
    }
    return null;
  }

  @override
  Future<dynamic> getMovieMovieDetail(id, type) async {

    var response = await http.get(Uri.parse('$endpoint/$type/$id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= Result.fromJson(jsonDecode(response.body));
      return data;
    }
    return null;
  }
  @override
  Future<dynamic> getSeason(id, season) async {

    var response = await http
        .get(Uri.parse('$endpoint/tv/$id/season/$season?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= getSeasonFromJson(response.body);
      return data;
    }
    return null;
  }
  @override
  Future searchMovie(String name) async {
    var response = await http.get(Uri.parse(
        '$endpoint/search/movie?query=$name&include_adult=false&language=en-US&page=1&api_key=$apiKey'));
    if (response.statusCode == 200) {
      var data= searchModelFromJson(response.body);
      return data;
    }
    throw Exception('Failed to load movie data');
  }
}
