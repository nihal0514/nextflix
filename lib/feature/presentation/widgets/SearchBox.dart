import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/Utils.dart';
import '../../data/model/Configuration.dart';
import '../../data/model/GetTrending.dart';
import 'Netlix_Bottom_Sheet.dart';
import 'PosterImage.dart';

class SearchBox extends StatelessWidget {
  const SearchBox(
      {super.key,
        required this.movie,
        this.fill = false,
        this.padding,
      required this.configuration});

  final Result movie;
  final bool fill;
  final EdgeInsets? padding;
  final Configuration configuration;

  @override
  Widget build(BuildContext context) {
    final imageAvailable = movie.posterPath != null;
    final thumbnailProvider = (imageAvailable
        ? CachedNetworkImageProvider(
        '${configuration.images?.baseUrl}/${configuration.images?.posterSizes?[1]}${movie.posterPath}')
        : const AssetImage(
      'assets/netflix_symbol.png',
    )) as ImageProvider;
    return Padding(
      padding:
      padding ?? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),

      child: InkWell(
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
                return SearchNetflixBottomSheet(
                  configuration: configuration,
                  thumbnail: thumbnailProvider,
                  movie: movie,
                );
              });
        },
        child: Stack(
          children: [
            fill
                ? Positioned.fill(
                child:
                SearchPosterImage(movie: movie, width: 300.0, height: 300.0,configuration: configuration,))
                : SearchPosterImage(movie: movie, width: 2000.0, height: 300.0,configuration: configuration,),
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/netflix_symbol.png',
                  width: 24.0,
                )),

          ],
        ),
      ),
    );
  }
}
