import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/GetTrending.dart';
import '../../bloc/netflix_bloc.dart';
import '../../widgets/NewAndHotTile.dart';
import '../../widgets/New_And_Hot_Header_Delegate.dart';

class NewAndHotScreen extends StatefulWidget {
  const NewAndHotScreen({super.key});

  @override
  State<NewAndHotScreen> createState() => _NewAndHotScreenState();
}

class _NewAndHotScreenState extends State<NewAndHotScreen>
    with SingleTickerProviderStateMixin {

  NetflixBloc netflixBloc= NetflixBloc();
  late int profileIndex;

  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        int newIndex = max(0, min(_scrollController.offset ~/ 3000, 2));
        if (_tabController.index != newIndex) {
          _tabController.animateTo(newIndex);
        }
      }
    });

  late final TabController _tabController =
  TabController(length: 3, vsync: this)
    ..addListener(() {
      if (_tabController.indexIsChanging &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.idle) {
        var offset = _scrollController.offset,
            minRange = offset - 300,
            maxRange = offset + 300,
            offsetTo = _tabController.index * 3000.0;

        if (!(minRange <= offsetTo && maxRange >= offsetTo)) {
          _scrollController.animateTo(_tabController.index * 3000.0,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 1000));
        }
      }
    });
  void _loadSharedPreferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? profileIndexPrefs = await prefs.getInt('profileIndex');
    profileIndex= profileIndexPrefs!;
    setState(() {

    });
  }


  @override
  void initState() {
  netflixBloc.add(DiscoverEvent());
  _loadSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<NetflixBloc, NetflixState>(
        bloc: netflixBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          if(state is DiscoverState){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    delegate: NewAndHotHeaderDelegate(tabController: _tabController,profileIndex: profileIndex),
                    pinned: true,
                  ),
                  Builder(builder: (context) {
                    final List<Result> movies= state.discoverTvShowsState.Movie as List<Result>;
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (context, index) => NewAndHotTile(
                                movie: movies[index],
                                    configuration: state.configurationMovieMoviesState.configuration,
                              ),
                              childCount: state.discoverTvShowsState.Movie.length));
                  }),
                  Builder(builder: (context) {
                    final List<Result> movies= state.discoverMovieMoviesState.Movie as List<Result>;
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (context, index) => NewAndHotTile(
                              movie: movies[index],
                                  configuration: state.configurationMovieMoviesState.configuration,
                            ),
                            childCount: state.discoverMovieMoviesState.Movie.length));
                  }),
      
                ],
              ),
            );
          }
          return SizedBox();
      
        },
      ),
    );
  }
}
