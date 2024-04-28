part of 'netflix_bloc.dart';

abstract class NetflixEvent {}

class NetflixInitial extends NetflixState {}

class NetflixInitialFetchEvent extends NetflixEvent {}

class NavigateSearchEvent extends NetflixEvent{}

class DiscoverMovieMoviesEvent extends NetflixEvent {}

class DiscoverTvShowsEvent extends NetflixEvent {}

class ConfigurationMovieMoviesEvent extends NetflixEvent {}

class OnBackPressedEvent extends NetflixEvent{

}

class GetImagesEvent extends NetflixEvent {
  String id;
  String type;

  GetImagesEvent({required this.id, required this.type});
}

class TrendingTvShowListWeeklyEvent extends NetflixEvent {

}

class TrendingTvShowListDailyEvent extends NetflixEvent {}

class TrendingMovieMovieListWeeklyEvent extends NetflixEvent {}

class TrendingMovieMovieListDailyEvent extends NetflixEvent {}

class AddUserEvent extends NetflixEvent{
  final String name;

  AddUserEvent(this.name);

}
class ShowAllUserEvent extends NetflixEvent{
}

class GetDetailsEvent extends NetflixEvent{
  String id;
  String type;
  int season;


  GetDetailsEvent(this.id, this.type,this.season);
}

class TvShowSeasonSelectorEvent extends NetflixEvent{
  int seasonId;
  int season;

  TvShowSeasonSelectorEvent(this.seasonId, this.season);
}
class DiscoverEvent extends NetflixEvent{

}


class searchEvent extends NetflixEvent{
  final String name;

  searchEvent(this.name);
}




