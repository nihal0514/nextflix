import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/model/Configuration.dart';
import 'movie_box.dart';

class HomeScreenText extends StatelessWidget {
  String text;
   HomeScreenText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400,color: Colors.white,decoration: TextDecoration.none),
      ),
    );
  }
}

class HomeScreenShimmer extends StatelessWidget {
   HomeScreenShimmer({super.key});

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
    child: Container(
      height: 180,
      width: double.maxFinite,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            6,
                (index) => Container(
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.red,
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: 4.0, vertical: 8.0),
            )),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        _shimmer,
        _shimmer,
        _shimmer,
        _shimmer
      ],
    );
  }
}

class HomeScreenTrendingList extends StatelessWidget {
  List<dynamic> Movie;
  final Configuration configuration;
   HomeScreenTrendingList({super.key,required this.Movie,required this.configuration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 230.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Movie.length,
            itemBuilder: (context, index) {
              final MovieMovie = Movie[index];
              return MovieBox(
                key: ValueKey(MovieMovie.id),
                MovieMovie: MovieMovie,
                configuration: configuration,
              );
            }));
  }
}


