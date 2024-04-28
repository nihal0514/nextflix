import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextflix/feature/data/model/Configuration.dart';
import '../../../core/utils/Utils.dart';
import '../../data/model/GetTrending.dart';
import 'Netlix_Bottom_Sheet.dart';
import 'PosterImage.dart';
class MovieBox extends StatelessWidget {
  const MovieBox(
      {super.key,
        required this.MovieMovie,
        this.laughs,
        this.fill = false,
        this.padding,
      required this.configuration});

  final Result MovieMovie;
  final int? laughs;
  final bool fill;
  final EdgeInsets? padding;
  final Configuration configuration;
  @override
  Widget build(BuildContext context) {
    final imageAvailable = MovieMovie.posterPath != null;
    final thumbnailProvider = (imageAvailable
        ? CachedNetworkImageProvider(
        '${configuration.images?.baseUrl}/${configuration.images?.posterSizes?[1]}${MovieMovie.posterPath}')
        : const AssetImage(
      'assets/netflix_symbol.png',
    )) as ImageProvider;
    return InkWell(
      onTap: (){
        showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            backgroundColor: bottomSheetColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
            ),
            builder: (context) {
              return NetflixBottomSheet(
                configuration: configuration,
                thumbnail: thumbnailProvider,
                MovieMovie: MovieMovie,
              );
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
        padding:
        padding ?? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Stack(
          children: [
            fill
                ?
            Positioned.fill(
                child:

                PosterImage(MovieMovie: MovieMovie, width: 150.0, height: 220.0))
                : PosterImage(MovieMovie: MovieMovie, width: 150.0, height: 220.0),
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/netflix_symbol.png',
                  width: 24.0,
                )),
            if (laughs != null)
              Positioned(
                bottom: 2.0,
                left: 4.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('\u{1F602}'),
                    Text(
                      '${laughs}K',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
