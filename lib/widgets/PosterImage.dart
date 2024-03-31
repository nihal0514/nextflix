import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/Configuration.dart';
import '../model/GetSeason.dart';
import '../model/GetTrending.dart';
import '../utils/Utils.dart';

class PosterImage  extends StatefulWidget {
  const PosterImage (
      {super.key,
        this.images,
        this.MovieMovie,
        this.episode,
        this.original = false,
        this.width,
        this.height,
        this.backdrop = false,
        this.borderRadius,
        this.fit= false
      });

  final Result? MovieMovie;
  final bool original;
  final bool backdrop;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Images? images;
  final Episode? episode;
  final bool? fit;

  @override
  State<PosterImage> createState() => _PosterImageState();
}

class _PosterImageState extends State<PosterImage> {
  @override
  Widget build(BuildContext context) {
    final imageAvailable = widget.MovieMovie?.posterPath != null ||
        widget.episode?.stillPath != null ||
        widget.MovieMovie?.backdropPath != null && widget.backdrop;
    final url = (imageAvailable
        ? widget.backdrop
        ? '${widget.images?.baseUrl==null ? 'http://image.tmdb.org/t/p/': widget.images?.baseUrl}${widget.original ? 'original' : widget.images?.backdropSizes?[1]== null? 'original' :  widget.images?.backdropSizes?[1]}${widget.MovieMovie?.backdropPath}'
        : widget.MovieMovie?.posterPath != null
        ? '${widget.images?.baseUrl==null ? 'http://image.tmdb.org/t/p/': widget.images?.baseUrl}${widget.original ? 'original' : widget.images?.posterSizes?[1]==null ? 'original' : widget.images?.posterSizes?[1]}${widget.MovieMovie?.posterPath}'
        : '${widget.images?.baseUrl==null ? 'http://image.tmdb.org/t/p/': widget.images?.baseUrl}${widget.original ? 'original' : widget.images?.stillSizes?[3]==null ? 'original' : widget.images?.stillSizes?[3]}${widget.episode?.stillPath}'
        : null);
    var updatedUrl = url?.replaceFirst("http", "https");
    return imageAvailable
        ? url != null
        ?
    CachedNetworkImage(
      imageUrl: updatedUrl ?? "",

      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
        child: Image(
          image: imageProvider,
          fit: widget.fit==true? BoxFit.fill:BoxFit.cover,
          width: widget.width,
          height: widget.height,
        ),
      ),
      placeholder: (context, url) => Shimmer(
        gradient: shimmerGradient,
        child: Container(
            decoration: BoxDecoration(
                borderRadius:
                widget.borderRadius ?? BorderRadius.circular(8.0),
                color: Colors.black),
            width: widget.width ??
                (widget.original || widget.backdrop ? double.infinity : 150.0),
            height: widget.height ?? (widget.original || widget.backdrop ? 180.0 : 68.0)),
      ),
      errorWidget: (context, url, error) => Container(
        width: 110.0,
        height: 220.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey),
        child: Image.asset(
          'assets/netflix_symbol.png',
        ),
      ),
    )
        : Image.asset(
      'assets/netflix_symbol.png',
    )
        : Container(
      width: 110.0,
      height: 220.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
      child: Image.asset(
        'assets/netflix_symbol.png',
      ),
    );
  }
}


