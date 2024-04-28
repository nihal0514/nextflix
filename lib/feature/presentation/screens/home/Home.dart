import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nextflix/feature/presentation/widgets/ConstantWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/Utils.dart';
import '../../bloc/netflix_bloc.dart';
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

  void _loadSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? profileIndexPrefs = await prefs.getInt('profileIndex');
    profileIndex = profileIndexPrefs!;
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NetflixBloc, NetflixState>(
        bloc: homeBloc,
        listener: (context, state) {
          // if(state is NavigateSearchScreenState){
          //   GoRouter.of(context).go('/search');
          // }
        },
        builder: (context, state) {
          if (state is CombinedMovieMovieState) {
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    Stack(
                      children: [
                        HighlightMovieMovie(
                          netflixBloc: homeBloc,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
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
                                      onPressed: () {},
                                      icon: const Icon(LucideIcons.cast)),
                                  IconButton(
                                    onPressed: () {
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
                    HomeScreenText(text: "Trending TV Shows This Week"),
                    HomeScreenTrendingList(Movie: state
                        .trendingTvShowListWeeklyState.Movie, configuration: state.configurationMovieMoviesState.configuration,),
                    HomeScreenText(text: 'Trending TV Shows Today'),
                    HomeScreenTrendingList(Movie: state
                        .trendingTvShowListDailyState.Movie, configuration: state.configurationMovieMoviesState.configuration,),
                    HomeScreenText(text: 'Trending Movies This Week'),
                    HomeScreenTrendingList(Movie: state
                        .trendingMovieMovieListWeeklyState.Movie, configuration: state.configurationMovieMoviesState.configuration,),
                    HomeScreenText(text: 'Trending Movies Today'),
                    HomeScreenTrendingList(Movie: state
                        .trendingMovieMovieListDailyState.Movie, configuration: state.configurationMovieMoviesState.configuration,),

                  ]),
                ),
              ],
            );
          }
          return HomeScreenShimmer();
        },
      ),
    );
  }
}
