import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:nextflix/model/Configuration.dart';
import 'package:nextflix/model/GetTrending.dart';
import 'package:nextflix/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database/Database.dart';
import '../db/entity/User.dart';
import '../model/GetImage.dart';
import '../model/GetSeason.dart';

part 'netflix_state.dart';
part 'netflix_event.dart';

class NetflixBloc extends Bloc<NetflixEvent,NetflixState>{

  NetflixBloc(): super(NetflixInitial()){

    on<NetflixInitialFetchEvent> (netflixInitialBloc);
    on<DiscoverMovieMoviesEvent> (discoverMovieMoviesBloc);
    on<ConfigurationMovieMoviesEvent>(configurationMovieMoviesBloc);
    on<TrendingTvShowListWeeklyEvent>(treningTvShowListWeeklyBloc);
    on<TrendingTvShowListDailyEvent>(treningTvShowListDailyBloc);
    on<TrendingMovieMovieListWeeklyEvent>(treningMovieMovieListWeeklyBloc);
    on<TrendingMovieMovieListDailyEvent>(treningMovieMovieListDailyBloc);
    on<GetImagesEvent>(getImagesBloc);
    on<AddUserEvent>(addUserEventBloc);
    on<ShowAllUserEvent> (showAllUsersBloc);
    on<GetDetailsEvent> (getDetailsEventBloc);
    on<TvShowSeasonSelectorEvent> (getShowSeasonSelectorBloc);
    on<DiscoverEvent>(discoverBloc);
    on<DiscoverTvShowsEvent>(discoverTvShowsBloc);
  }

  final ApiRepository repository= ApiRepository();

  FutureOr<void> netflixInitialBloc(NetflixInitialFetchEvent event, Emitter<NetflixState> emit) async {

    final discoverMovieMoviesMovie =await discoverMovieMoviesBloc(DiscoverMovieMoviesEvent(), emit);
    final configurationMovieMoviesMovie =await configurationMovieMoviesBloc(ConfigurationMovieMoviesEvent(), emit);
    final treningTvShowListWeeklyMovie= await treningTvShowListWeeklyBloc(TrendingTvShowListWeeklyEvent(),emit);
    final treningTvShowListDailyMovie= await treningTvShowListDailyBloc(TrendingTvShowListDailyEvent(),emit);
    final treningMovieMovieListWeeklyMovie= await treningMovieMovieListWeeklyBloc(TrendingMovieMovieListWeeklyEvent(),emit);
    final treningMovieMovieListDailyMovie= await treningMovieMovieListDailyBloc(TrendingMovieMovieListDailyEvent(),emit);
    final combinedState = CombinedMovieMovieState(discoverMovieMoviesMovie,configurationMovieMoviesMovie,treningTvShowListWeeklyMovie,treningTvShowListDailyMovie,treningMovieMovieListWeeklyMovie,treningMovieMovieListDailyMovie
    );

    emit(combinedState);
  }


  FutureOr<DiscoverMovieMoviesState> discoverMovieMoviesBloc(DiscoverMovieMoviesEvent event, Emitter<NetflixState> emit) async{

   var  res= await repository.getDiscover('movie');
   return DiscoverMovieMoviesState(res);

  }

  FutureOr<ConfigurationMovieMoviesState> configurationMovieMoviesBloc(ConfigurationMovieMoviesEvent event, Emitter<NetflixState> emit) async{
    var  res= await repository.getConfiguration();
    return ConfigurationMovieMoviesState(res!!);
  }
  



  FutureOr<void> getImagesBloc(GetImagesEvent event, Emitter<NetflixState> emit)async {

    var res= await repository.getImages(event.id, event.type);
    emit(GetImagesState(res!!));
  }

  FutureOr<dynamic> treningTvShowListWeeklyBloc(TrendingTvShowListWeeklyEvent event, Emitter<NetflixState> emit) async{
    var  res= await repository.getTrending(type: 'tv');
    return TrendingTvShowListWeeklyState(res);

  }

  FutureOr<dynamic> treningTvShowListDailyBloc(TrendingTvShowListDailyEvent event, Emitter<NetflixState> emit) async{
    var  res= await repository.getTrending(type: 'tv',time: 'day');
    return TrendingTvShowListDailyState(res);

  }

  FutureOr<dynamic> treningMovieMovieListWeeklyBloc(TrendingMovieMovieListWeeklyEvent event, Emitter<NetflixState> emit)async {
    var  res= await repository.getTrending(type: 'movie');
    return TrendingMovieMovieListWeeklyState(res);

  }

  FutureOr<dynamic> treningMovieMovieListDailyBloc(TrendingMovieMovieListDailyEvent event, Emitter<NetflixState> emit)async {
    var  res= await repository.getTrending(type: 'movie',time: 'day');
    return TrendingMovieMovieListDailyState(res);

  }

  FutureOr<void> addUserEventBloc(AddUserEvent event, Emitter<NetflixState> emit) async{

    final database = await $FloorMyAppDatabase.databaseBuilder('my_app_database.db').build();
    final userDao = database.userDao;

    final name = User(null, event.name);
    await userDao.insertUser(name);

  }

  FutureOr<void> showAllUsersBloc(ShowAllUserEvent event, Emitter<NetflixState> emit)async {

    final database = await $FloorMyAppDatabase.databaseBuilder('my_app_database.db').build();
    final userDao = database.userDao;
    List<User> users=await userDao.showAllUsers();

    emit(ShowUserList(users));
  }


  FutureOr<void> getDetailsEventBloc(GetDetailsEvent event, Emitter<NetflixState> emit) async{
    var movieDetailRes= await repository.getMovieMovieDetail(event.id, event.type);
    var season;
    if(event.type=='tv'){
       season= await repository.getSeason(event.id,event.season );
    }

    var  trending= await repository.getTrending(type: 'tv');
    var  configuration= await repository.getConfiguration();
    var trendinglist= await repository.getTrending(type: 'tv',time: 'day');

    emit(GetDetailsState(movieDetailRes,season,trending,configuration,trendinglist));
  }


  FutureOr<void> getShowSeasonSelectorBloc(TvShowSeasonSelectorEvent event, Emitter<NetflixState> emit) async{
    var res= await repository.getSeason(event.seasonId, event.season);

    emit(TvShowSeasonSelectorState(res!));

  }

  FutureOr<void> discoverBloc(DiscoverEvent event, Emitter<NetflixState> emit)async {
    final discoverMovieMoviesMovie =await discoverMovieMoviesBloc(DiscoverMovieMoviesEvent(), emit);
    final discoverTvShows =await discoverTvShowsBloc(DiscoverTvShowsEvent(), emit);
    final configurationMovieMoviesMovie =await configurationMovieMoviesBloc(ConfigurationMovieMoviesEvent(), emit);
    final discoverState = DiscoverState(discoverMovieMoviesMovie,discoverTvShows,configurationMovieMoviesMovie);

    emit(discoverState);
  }

  FutureOr<dynamic> discoverTvShowsBloc(DiscoverTvShowsEvent event, Emitter<NetflixState> emit) async{
    var  res= await repository.getDiscover('tv');
    return DiscoverTvShowsState(res);
  }
}
