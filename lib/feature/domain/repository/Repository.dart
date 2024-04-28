import '../../data/model/Configuration.dart';
import '../../data/model/GetImage.dart';

abstract class Repository {
  Future<dynamic> searchMovie(String name);

  Future<dynamic> getTrending({type = 'all', time = 'week'}) async {}

  Future<dynamic> getDiscover(type) async {}

  Future<Configuration?> getConfiguration() async {}

  Future<GetImages?> getImages(id, type) async {}

  Future<dynamic> getMovieMovieDetail(id, type) async {}

  Future<dynamic> getSeason(id, season) async {}
}
