import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/netflix_bloc.dart';
import '../model/Configuration.dart';
import '../model/GetTrending.dart';
import '../utils/utils.dart';
import 'BottomSheetButton.dart';

class NetflixBottomSheet extends StatefulWidget {
  NetflixBottomSheet(
      {super.key, required this.thumbnail, required this.MovieMovie, required this.configuration});

  final ImageProvider thumbnail;
  final Result MovieMovie;
  final Configuration configuration;

  @override
  State<NetflixBottomSheet> createState() => _NetflixBottomSheetState();
}

class _NetflixBottomSheetState extends State<NetflixBottomSheet> {
  final NetflixBloc netflixBloc = NetflixBloc();
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
    child: Row(
      children: const [
        Text(
          '2022',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '18+',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '10 Episodes',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
      ],
    ),
  );

  String runtime= '10 Episodes';

  @override
  void initState() {
    print(widget.MovieMovie.mediaType);
    netflixBloc.add(GetDetailsEvent(widget.MovieMovie.id.toString(), widget.MovieMovie.mediaType.toString(),1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer(
        bloc: netflixBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          if(state is GetDetailsState){
           /* if(widget.MovieMovie.mediaType=='movie'){
              var hours = state.MovieMovieDetail.! / 60,
                  justHours = hours.floor(),
                  minutes = ((hours - hours.floor()) * 60).floor();


              runtime= '${justHours > 0 ? '${justHours}h' : ''}${minutes > 0 ? '${justHours > 0 ? ' ' : ''}${minutes}m' : ''}';
            }*/
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image(
                              image: widget.thumbnail,
                              fit: BoxFit.contain,
                              width: 88.0,
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Image.asset(
                                'assets/netflix_symbol.png',
                                width: 24.0,
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                    textDirection: TextDirection.ltr,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.MovieMovie.mediaType== 'movie'? widget.MovieMovie.title.toString() : widget.MovieMovie.name.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                     Row(
                                        children: [
                                          Text(
                                            '${state.MovieMovieDetail?.releaseDate?.year ??
                                                '2022'}',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          const Text(
                                            '18+',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          if(widget.MovieMovie.mediaType=="tv")
                                            Text(
                                            runtime,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100.0),
                                  radius: 32.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: bottomSheetIconColor,
                                        borderRadius:
                                        BorderRadius.circular(100.0)),
                                    child: const Icon(
                                      LucideIcons.x,
                                      size: 28.0,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              widget.MovieMovie.overview.toString(),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    BottomSheetButton(
                      icon: Icons.play_arrow,
                      label: 'Play',
                      size: 32.0,
                      padding:
                      EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      light: true,
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.download,
                      label: 'Download',
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.plus,
                      label: 'My List',
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.share2,
                      label: 'Share',
                    )
                  ],
                ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go('/home/details', extra: {'extra': state.MovieMovieDetail,'configExtra': widget.configuration,'type': widget.MovieMovie.mediaType});

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.info),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(widget.MovieMovie.mediaType == 'tv'
                                ? 'Episodes & Info'
                                : 'Details & More'),
                          ],
                        ),
                        const Icon(LucideIcons.chevronRight)
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return SizedBox();

        },
      );
  }

}
/*
class SearchNetflixBottomSheet extends StatelessWidget {
  SearchNetflixBottomSheet({super.key, required this.thumbnail, required this.MovieMovie});

  final ImageProvider thumbnail;
  final Movie MovieMovie;

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
    child: Row(
      children: const [
        Text(
          '2022',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '18+',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '10 Episodes',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
        context.watch<TMDBRepository>().getDetails(MovieMovie.id, "MovieMovie"),
        builder: (context, AsyncSnapshot<MovieMovie> snapshoot) {
          final MovieMovieDetails = snapshoot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image(
                            image: thumbnail,
                            fit: BoxFit.contain,
                            width: 88.0,
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              'assets/netflix_symbol.png',
                              width: 24.0,
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      MovieMovie.title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    snapshoot.hasError || !snapshoot.hasData
                                        ? _shimmer
                                        : Row(
                                      children: [
                                        Text(
                                          '${MovieMovieDetails?.releaseDate?.year ?? '2022'}',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0),
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        const Text(
                                          '18+',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0),
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          MovieMovieDetails?.getRuntime() ??
                                              '10 Episodes',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(100.0),
                                radius: 32.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: bottomSheetIconColor,
                                      borderRadius:
                                      BorderRadius.circular(100.0)),
                                  child: const Icon(
                                    LucideIcons.x,
                                    size: 28.0,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            MovieMovie.overview!,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
           */
/*     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BottomSheetButton(
                      icon: Icons.play_arrow,
                      label: 'Play',
                      size: 32.0,
                      padding:
                      EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      light: true,
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.download,
                      label: 'Download',
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.plus,
                      label: 'My List',
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.share2,
                      label: 'Share',
                    )
                  ],
                ),*/ /*

                const Divider(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    context.go('${GoRouter.of(context).location}/details',
                        extra: MovieMovieDetails);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(LucideIcons.info),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text('Details & More'),
                        ],
                      ),
                      const Icon(LucideIcons.chevronRight)
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
*/
