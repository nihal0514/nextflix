import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nextflix/cubit/MovieDetailsTabCubit.dart';
import 'package:nextflix/model/GetTrending.dart';
import 'package:provider/provider.dart';

import '../../bloc/netflix_bloc.dart';
import '../../model/Configuration.dart';
import '../../utils/Utils.dart';

import '../../widgets/EpisodeBox.dart';
import '../../widgets/MovieTrailer.dart';
import '../../widgets/NetflixDropDownScreen.dart';
import '../../widgets/NewAndHotTileAction.dart';
import '../../widgets/PosterImage.dart';
import '../../widgets/movie_box.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.Movie,required this.configuration,required this.type});

  final Result Movie;
  final Configuration configuration;
  final String type;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  final NetflixBloc movieDetailsBloc = NetflixBloc();
  final MovieDetailsTabCubit movieDetailsTabCubit= MovieDetailsTabCubit();
  late final TabController _tabController ;

  @override
  void initState() {

    movieDetailsBloc.add(GetDetailsEvent(widget.Movie.id.toString(), widget.type,1));
    _tabController = TabController(length:widget.type=="tv"? 3: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    super.initState();
  }
  void _handleTabChange() {

    int currentIndex = _tabController.index;
    movieDetailsTabCubit.setTab(currentIndex);
    print('Tab changed to index $currentIndex');
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
          bloc: movieDetailsBloc,
          builder: (context, state) {
            if (state is GetDetailsState) {
              movieDetailsBloc.add(ConfigurationMovieMoviesEvent());
              return _buildDetails(state.MovieMovieDetail,movieDetailsBloc);
            }
            return SizedBox();
          });

  }

  Widget _buildDetails(Result Movie,NetflixBloc movieDetailsBloc) {
    return BlocBuilder(
      bloc: movieDetailsBloc,
      builder: (context, state) {
        if (state is GetDetailsState) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(LucideIcons.arrowLeft),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(LucideIcons.cast),
                    onPressed: () {},
                  ),
                ],
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                     Stack(
                children: [
                  PosterImage(
                    images: widget.configuration.images,
                    original: true,
                    borderRadius: BorderRadius.zero,
                    MovieMovie: Movie,
                    backdrop: true,
                    width: double.maxFinite,
                    height: 300,
                  ),
                  Positioned(
                      bottom: 12.0,
                      left: 6.0,
                      child: SizedBox(
                        height: 32.0,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black.withOpacity(.3)),
                            onPressed: () {},
                            child: const Text('Preview')),
                      )),
                  Positioned(
                      bottom: 6.0,
                      right: 6.0,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.volumeX)))
                ],
              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.type=="tv"? Movie.name ?? "": Movie.title ?? "",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 32.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                      '${(Movie.firstAirDate?.year) ?? "2020"}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Colors.grey.shade700),
                              child: const Text(
                                '16+',
                                style: TextStyle(letterSpacing: 1.0),
                              )),
                          const SizedBox(
                            width: 8.0,
                          ),

                          const SizedBox(
                            width: 8.0,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: Colors.grey.shade300),
                              child: const Text(
                                'HD',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              backgroundColor: Colors.grey.shade900,
                              foregroundColor: Colors.white),
                          onPressed: () {},
                          icon: const Icon(LucideIcons.download),
                          label:  Text(widget.type=="tv"?"Download S1:E1":'Download ')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Movie.overview.toString()),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                              'Starring: Bob Odenkirk, Jonathan Banks, Rhea Seehorn...'),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text('Creators: Vince Gilligan, Peter Gould'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        NewAndHotTileAction(
                          icon: LucideIcons.plus,
                          label: 'My List',
                        ),
                        NewAndHotTileAction(
                          icon: LucideIcons.thumbsUp,
                          label: 'Rate',
                        ),
                        NewAndHotTileAction(
                          icon: LucideIcons.share2,
                          label: 'Share',
                        ),
                        if(widget.type=="tv")
                          NewAndHotTileAction(
                          icon: LucideIcons.download,
                          label: 'Download Season 1',
                        )
                      ],
                    ),
                    const Text(
                      'Fast Laughs',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 20,),
                    const Divider(
                      height: 1.0,
                    ),
                    TabBar(
                        controller: _tabController,
                        indicator: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: redColor,
                                width: 4.0,
                              )),
                        ),
                        tabs: [
                            if (widget.type == 'tv')
                              const Tab(
                                child: Text('Episodes',style: TextStyle(color: Colors.white),),
                              ),
                          const Tab(
                            child: Text('Trailers & More',style: TextStyle(color: Colors.white),),
                          ),
                          const Tab(
                            child: Text('More Like This',style: TextStyle(color: Colors.white),),
                          ),
                        ]),
                  ])),
              BlocBuilder(
                bloc: movieDetailsTabCubit,
                  builder: (context,state2){
                    return Builder(builder: (context) {
                        final tabIndex = state2;
                      print("_tabController.index ${_tabController.index}");
                      if (tabIndex == 0 && widget.type == 'tv') {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            if (index == 0) {
                              return _seasonDropdown(Movie, state.getSeason!.seasonNumber!,movieDetailsBloc);
                            }

                            return EpisodeBox(
                                episode: state.getSeason!.episodes![index - 1],
                                fill: true,
                                padding: EdgeInsets.zero);
                          }, childCount: state.getSeason!.episodes!.length + 1),
                        );
                      } else if (tabIndex == 1
                      && widget.type == 'tv'
                                ||
                                tabIndex == 0 && widget.type == 'movie'
                      ) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final movie = state.trending[index];
                            return MovieTrailer(
                                key: ValueKey(movie?.id),
                                movie: movie,
                                fill: true,
                                padding: EdgeInsets.zero);
                          }, childCount: state.trending.length),
                        );
                      } else {
                        final movies= state.trendinglist;
                          return SliverGrid(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              final movie = movies[index];
                              return MovieBox(
                                configuration: state.configuration!,
                                  key: ValueKey(movie.id),
                                  MovieMovie: movie,
                                  fill: true,
                                  padding: EdgeInsets.zero);
                            }, childCount: min(12, movies.length)),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 3,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0),
                          );

                      }});
                  })

            ],
          );
        }
        return SizedBox();
      },
    );
  }

 void _openSeasonSelector(Result Movie,int seasonNumber,NetflixBloc movieDetailsBloc) {
    OverlayEntry? overlay;
    overlay = OverlayEntry(
      builder: (context) {
        return NetflixDropDownScreen(
            movie: Movie,
            selected: seasonNumber,
            change: (season){
              movieDetailsBloc.add(GetDetailsEvent(Movie.id.toString(), "tv",season));

            },
            onPop: () {
              overlay?.remove();
            });
      },
    );

    Overlay.of(context, rootOverlay: true)?.insert(overlay);
  }

  Widget _seasonDropdown(Result Movie, int seasonNumber,NetflixBloc movieDetailsBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6.0,
        ),
        ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade900),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Season $seasonNumber',
                  style: const TextStyle
                    (color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 14.0,
                  color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              _openSeasonSelector(Movie,seasonNumber,movieDetailsBloc);

            }),
        const SizedBox(
          height: 12.0,
        )
      ],
    );
  }
}
