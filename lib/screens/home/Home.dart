import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nextflix/bloc/netflix_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/Utils.dart';
import '../../widgets/HighlightMovie.dart';
import '../../widgets/ProfileIcon.dart';
import '../../widgets/movie_box.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.name});

  final String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Duration _duration = const Duration(milliseconds: 150);
  final NetflixBloc homeBloc = NetflixBloc();
  late int profileIndex;

  double _scrollOffset = 0.0;
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

  @override
  void initState() {
    homeBloc.add(NetflixInitialFetchEvent());

    _loadSharedPreferences();
    super.initState();

  }
  void _loadSharedPreferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? profileIndexPrefs = await prefs.getInt('profileIndex');
    profileIndex= profileIndexPrefs!;
    setState(() {

    });
  }

  final _shimmer = Shimmer(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.grey[900]!,
          Colors.grey[900]!,
          Colors.grey[800]!,
          Colors.grey[900]!,
          Colors.grey[900]!
        ],
        stops: const <double>[
          0.0,
          0.35,
          0.5,
          0.65,
          1.0
        ]),
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
          6,
              (index) =>
              Container(
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red,
                ),
                margin:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              )),
    ),
  );

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(top: 16.0, bottom: 4.0);
    return Scaffold(
      body: BlocConsumer<NetflixBloc, NetflixState>(
        bloc: homeBloc,
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is CombinedMovieMovieState){
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    Stack(
                      children: [
                        HighlightMovieMovie( netflixBloc: homeBloc,),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/netflix_symbol.png',
                                height: 72.0,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {}, icon: const Icon(LucideIcons.cast)),
                                  IconButton(
                                      onPressed: () {}, icon: const Icon(LucideIcons.search)),
                                  IconButton(
                                    onPressed: (){
                                           context.go('/');
                                    },
                                    icon: Builder(builder: (context) {
                                      return ProfileIcon(
                                        color: profileColors[profileIndex],
                                        iconSize: IconTheme.of(context).size,
                                      );
                                    }),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: padding,
                      child: Text(
                        'Trending TV Shows This Week',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trendingTvShowListWeeklyState.Movie.length,
                          itemBuilder: (context, index) {
                            final MovieMovie = state.trendingTvShowListWeeklyState.Movie[index];
                            return MovieBox(
                              key: ValueKey(MovieMovie.id),
                              MovieMovie: MovieMovie,
                              configuration: state.configurationMovieMoviesState.configuration,
                            );
                          })
                    ),
                    const Padding(
                      padding: padding,
                      child: Text(
                        'Trending TV Shows Today',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trendingTvShowListDailyState.Movie.length,
                          itemBuilder: (context, index) {
                            final MovieMovie = state.trendingTvShowListDailyState.Movie[index];
                            return MovieBox(
                              key: ValueKey(MovieMovie.id),
                              MovieMovie: MovieMovie,
                              configuration: state.configurationMovieMoviesState.configuration,
                            );
                          })
                    ),
                    const Padding(
                      padding: padding,
                      child: Text(
                        'Trending Movies This Week',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                      child:  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trendingMovieMovieListWeeklyState.Movie.length,
                          itemBuilder: (context, index) {
                            final MovieMovie = state.trendingMovieMovieListWeeklyState.Movie[index];
                            return MovieBox(
                              key: ValueKey(MovieMovie.id),
                              MovieMovie: MovieMovie,
                              configuration: state.configurationMovieMoviesState.configuration,
                            );
                          })
                    ),
                    const Padding(
                      padding: padding,
                      child: Text(
                        'Trending Movies Today',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.none),
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trendingMovieMovieListDailyState.Movie.length,
                          itemBuilder: (context, index) {
                            final MovieMovie = state.trendingMovieMovieListDailyState.Movie[index];
                            return MovieBox(
                              key: ValueKey(MovieMovie.id),
                              MovieMovie: MovieMovie,
                              configuration: state.configurationMovieMoviesState.configuration,
                            );
                          })
                    ),
                  ]),
                ),
              ],
            );
          }
          return SizedBox();


        },
      ),
    );
  }
}
