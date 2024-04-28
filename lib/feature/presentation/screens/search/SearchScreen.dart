import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextflix/core/utils/Utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/netflix_bloc.dart';
import '../../widgets/SearchBox.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NetflixBloc netflixBloc = NetflixBloc();
  final movieSearchTextController = TextEditingController();

  @override
  void dispose() {
    movieSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            children: [
              TextField(
                controller: movieSearchTextController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  focusColor: primaryRed,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Border color when focused
                  ),

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryRed
                    )
                  ),
                  hintText: 'Search',
                ),
                onChanged: (text) {
                  netflixBloc.add(searchEvent(text));
                },
              ),
              BlocConsumer<NetflixBloc, NetflixState>(
                bloc: netflixBloc,
                listener: (context, state) {
                },
                builder: (context, state) {
                  if(state is searchListResult){
                    return Expanded(
                      child: GridView.builder(
                        itemCount: state.searchResultList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final movie = state.searchResultList[index];
                          return SearchBox(
                            configuration: state.configuration!,
                            key: ValueKey(movie.id),
                            movie: movie,
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
