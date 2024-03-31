import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nextflix/bloc/netflix_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/Utils.dart';
import 'Genre.dart';
import 'LogoImage.dart';
import 'NewAndHotTileAction.dart';
import 'PosterImage.dart';

class HighlightMovieMovie extends StatelessWidget {
  final NetflixBloc netflixBloc;

  HighlightMovieMovie({super.key, required this.netflixBloc});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var combinedMovieMovieStateVar = netflixBloc.state;
    if (combinedMovieMovieStateVar is CombinedMovieMovieState) {

      var MovieMovies = combinedMovieMovieStateVar.discoverMovieMoviesState;
      var images = combinedMovieMovieStateVar.configurationMovieMoviesState;


      return Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: const Alignment(0.0, 0.2),
                    colors: [
                      Colors.black,
                      Colors.black.withOpacity(.92),
                      Colors.black.withOpacity(.8),
                      Colors.transparent
                    ])),
            child: PosterImage(
              images: images.configuration.images,
              original: true,
              borderRadius: BorderRadius.zero,
              MovieMovie: MovieMovies?.Movie?.first,
              width: width,
              height: width + (width * .6),
            ),
          ),
          Positioned(
            bottom: 0.0,
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 38.0, vertical: 16.0),
              child: Column(
                children: [
                   LogoImage(
                      configuration: images.configuration,
                      MovieMovie: MovieMovies.Movie.first,
                      size: 3,
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Genre(
                    genres: ['Pshychological', 'Dark', 'Drama', 'MovieMovie'],
                    color: redColor,
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const NewAndHotTileAction(
                          icon: LucideIcons.plus,
                          label: 'My List',
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 12.0, vertical: 4.0),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black),
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Play')),
                        const NewAndHotTileAction(
                          icon: LucideIcons.info,
                          label: 'Info',
                        ),
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Shimmer(
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
      child: SizedBox(
        width: width,
        height: width + (width * .6),
      ),
    );
  }
}

