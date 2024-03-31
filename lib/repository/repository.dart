import 'dart:convert';

import 'package:nextflix/model/Configuration.dart';
import 'package:nextflix/model/GetImage.dart';
import 'package:nextflix/model/Discover.dart';
import 'package:http/http.dart' as http;
import 'package:nextflix/model/GetSeason.dart';
import 'package:nextflix/model/GetTrending.dart';
import '../api/api.dart';

class ApiRepository{

  String endpoint = Api.endpoint;
  String apiKey= Api.apiKey;
  Future<dynamic> getTrending({type = 'all', time = 'week'}) async {

    var response = await http.get(Uri.parse('$endpoint/trending/$type/$time?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= trendingFromJson(response.body);
      return data.results;
    }
    return [];
  }


  Future<dynamic> getDiscover(type) async {

    var response = await http.get(Uri.parse('$endpoint/discover/$type?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= discoverFromJson(response.body);
      return data.results;
    }
    return [];
  }

  Future<Configuration?> getConfiguration() async {

    var response = await http.get(Uri.parse('$endpoint/configuration?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= configurationFromJson(response.body);
      return data;
    }
    return null;
  }

  Future<GetImages?> getImages(id, type) async {

    var response = await http.get(Uri.parse('$endpoint/$type/$id/images?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= getImagesFromJson(response.body);
      return data;
    }
    return null;
  }

  Future<dynamic> getMovieMovieDetail(id, type) async {

    var response = await http.get(Uri.parse('$endpoint/$type/$id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= Result.fromJson(jsonDecode(response.body));
      return data;
    }
    return null;
  }
  Future<dynamic> getSeason(id, season) async {

    var response = await http
        .get(Uri.parse('$endpoint/tv/$id/season/$season?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data= getSeasonFromJson(response.body);
      return data;
    }
    return null;
  }
}