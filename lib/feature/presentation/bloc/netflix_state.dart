part of 'netflix_bloc.dart';

abstract class NetflixState {}

abstract class NetflixActionState extends NetflixState{}

class DiscoverMovieMoviesState extends NetflixState{

  final List<dynamic> Movie;
  DiscoverMovieMoviesState(this.Movie);
}

class DiscoverTvShowsState extends NetflixState{

  final List<dynamic> Movie;
  DiscoverTvShowsState(this.Movie);
}

class ConfigurationMovieMoviesState extends NetflixState{

  final Configuration configuration;
  ConfigurationMovieMoviesState(this.configuration);
}

class CombinedMovieMovieState extends NetflixState{
  final DiscoverMovieMoviesState discoverMovieMoviesState;
  final ConfigurationMovieMoviesState configurationMovieMoviesState;
  final dynamic trendingTvShowListWeeklyState;
  final dynamic trendingTvShowListDailyState;
  final dynamic trendingMovieMovieListWeeklyState;
  final dynamic trendingMovieMovieListDailyState;

  CombinedMovieMovieState(
      this.discoverMovieMoviesState,
      this.configurationMovieMoviesState,
      this.trendingTvShowListWeeklyState,
      this.trendingTvShowListDailyState,
      this.trendingMovieMovieListWeeklyState,
      this.trendingMovieMovieListDailyState);
}

class DiscoverState extends NetflixState{
  final DiscoverMovieMoviesState discoverMovieMoviesState;
  final DiscoverTvShowsState discoverTvShowsState;
  final ConfigurationMovieMoviesState configurationMovieMoviesState;

  DiscoverState(
      this.discoverMovieMoviesState,
      this.discoverTvShowsState,
      this.configurationMovieMoviesState);
}

class GetImagesState extends NetflixState{
  final GetImages getImages;

  GetImagesState(this.getImages);
}


class TrendingTvShowListWeeklyState extends NetflixState {
  final List<dynamic> Movie;

  TrendingTvShowListWeeklyState(this.Movie);
}

class TrendingTvShowListDailyState extends NetflixState {
  final List<dynamic> Movie;

  TrendingTvShowListDailyState(this.Movie);
}

class TrendingMovieMovieListWeeklyState extends NetflixState {
  final List<dynamic> Movie;

  TrendingMovieMovieListWeeklyState(this.Movie);
}

class TrendingMovieMovieListDailyState extends NetflixState {
  final List<dynamic> Movie;

  TrendingMovieMovieListDailyState(this.Movie);
}

class ShowUserList extends NetflixState{
  final List<User> users;

  ShowUserList(this.users);
}

class GetDetailsState extends NetflixState{
  final Result MovieMovieDetail;
  final GetSeason? getSeason;
  final List<Result> trending;
  final Configuration? configuration;
  final List<dynamic> trendinglist;

  GetDetailsState(this.MovieMovieDetail,this.getSeason,this.trending,this.configuration,this.trendinglist);
}

class TvShowSeasonSelectorState extends NetflixState{
  final GetSeason getSeason;

  TvShowSeasonSelectorState(this.getSeason);
}

class NavigateSearchScreenState extends NetflixActionState{}

class searchListResult extends NetflixState{
  final List<Result> searchResultList;
  final Configuration? configuration;

  searchListResult(this.searchResultList,this.configuration);
}

class OnBackPressedState extends NetflixActionState{
}
