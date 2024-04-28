import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextflix/feature/data/model/Configuration.dart';

import '../../data/model/GetTrending.dart';
import '../bloc/netflix_bloc.dart';
class LogoImage extends StatefulWidget {
  const LogoImage(
      {super.key,
      required this.MovieMovie,
      this.size = 1,
      required this.configuration});


  final Result MovieMovie;
  final Configuration configuration;
  final int size;

  @override
  State<LogoImage> createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage> {
  final NetflixBloc homeBloc = NetflixBloc();

  @override
  void initState() {
    homeBloc.add(GetImagesEvent(
        id: widget.MovieMovie.id.toString(), type: widget.MovieMovie.mediaType ?? "movie"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetflixBloc, NetflixState>(
      bloc: homeBloc,
      listener: (context, state) {
      },
      builder: (context, state) {
        if (state is GetImagesState) {
          final url =
              '${widget.configuration.images?.baseUrl}${widget.configuration.images?.logoSizes?[widget.size]}${state.getImages.logos?[0].filePath}';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CachedNetworkImage(
                imageUrl: url
            )
          );
        }
        return SizedBox();
      },
    );

  }
}
