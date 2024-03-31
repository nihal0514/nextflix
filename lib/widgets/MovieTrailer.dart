import 'package:flutter/material.dart';

import '../model/GetTrending.dart';
import 'PosterImage.dart';

class MovieTrailer extends StatelessWidget {
  const MovieTrailer(
      {super.key, required this.movie, this.fill = false, this.padding});

  final Result movie;
  final bool fill;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PosterImage(MovieMovie: movie, original: true),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          movie.name.toString(),
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 32.0,
        )
      ],
    );
  }
}
