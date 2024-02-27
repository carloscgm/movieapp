import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/type_movie_list.dart';
import 'package:movieapp/presentation/utils/widgets/movies/custom_poster_movie.dart';
import 'package:movieapp/presentation/view/movie/bloc/movie_bloc.dart';

class FullScreenMovieListPage extends StatefulWidget {
  final List<PostableItem> list;
  final MovieListType listType;
  const FullScreenMovieListPage(
      {super.key, required this.list, required this.listType});

  @override
  State<FullScreenMovieListPage> createState() =>
      _FullScreenMovieListPageState();
}

class _FullScreenMovieListPageState extends State<FullScreenMovieListPage> {
  List<PostableItem> _myList = List.empty(growable: true);
  List<PostableItem> _column1List = List.empty(growable: true);
  List<PostableItem> _column2List = List.empty(growable: true);
  List<PostableItem> _column3List = List.empty(growable: true);
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _myList = widget.list;
    splitMoviesInColumns();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().moveMoviesToNext(widget.listType);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 50 >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        _currentPage++;
        loading = true;
        context.read<MovieBloc>().fetchNext(_currentPage, widget.listType);
      }
    });

    final responsive = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.mediumMargin),
          child: HeroMode(
            enabled: false,
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (BuildContext context, state) {
                if (state.nextList.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  _myList = state.nextList;
                  loading = false;
                  splitMoviesInColumns();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _customColum(_column1List, responsive.height * 0.05,
                          widget.listType),
                      const SizedBox(width: 3),
                      _customColum(_column2List, responsive.height * 0.15,
                          widget.listType),
                      const SizedBox(width: 3),
                      _customColum(_column3List, responsive.height * 0.10,
                          widget.listType),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void splitMoviesInColumns() {
    _column1List = [];
    _column2List = [];
    _column3List = [];
    for (int i = 0; i < _myList.length; i++) {
      switch (i % 3) {
        case 0:
          _column1List.add(_myList[i]);
          break;
        case 1:
          _column2List.add(_myList[i]);
          break;
        case 2:
          _column3List.add(_myList[i]);
          break;
      }
    }
  }

  Widget _customColum(
      List<PostableItem> movieList, double offset, MovieListType typeItem) {
    return Container(
      margin: EdgeInsets.only(top: offset),
      child: Column(
          children: List.generate(
              movieList.length,
              (index) => CustomPosterMovie(
                    title: movieList[index].title,
                    backdropPath: movieList[index].backdropPath,
                    id: movieList[index].id,
                    posterPath: movieList[index].posterPath,
                    margen: 5,
                    vote: movieList[index].voteAverage.toString(),
                    typeItem: typeItem,
                  )).toList()),
    );
  }
}
