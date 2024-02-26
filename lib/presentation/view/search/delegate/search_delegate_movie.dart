import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/models/movie_model.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:movieapp/presentation/view/search/bloc/search_bloc.dart';

class SearchMovieDelegate extends SearchDelegate {
  SearchMovieDelegate();

  int _currentPage = 1;
  Timer? _debounceTimer;

  void _onQueryChange(BuildContext context, String newQuery) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (newQuery.isEmpty) return;
        _currentPage = 1;
        context.read<SearchBloc>().searchNextPage(newQuery, _currentPage);
      },
    );
  }

  @override
  String? get searchFieldLabel => 'Nombra una película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () {
              context.read<SearchBloc>().clean();
              _currentPage = 1;
            },
            icon: const Icon(Icons.clear)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<SearchBloc>().addNewSearched(query);
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          _currentPage++;
          context.read<SearchBloc>().searchNextPage(query, _currentPage);
        }
      },
    );

    return BlocBuilder<SearchBloc, SearchBlocState>(
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
          itemCount: state.searchResult.length,
          itemBuilder: (context, index) {
            return _CustomListTile(movie: state.searchResult[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(context, query);
    return BlocBuilder<SearchBloc, SearchBlocState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.searchResult.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(state.searchResult[index].title));
          },
        );
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final MovieModel movie;
  const _CustomListTile({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            decoration: AppStyles.getDecorationPoster(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: movie.posterPath.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: movie.posterPath,
                      height: size.width * 0.2 * 1.5,
                      fit: BoxFit.fill,
                      width: size.width * 0.2,
                    )
                  : Container(
                      height: size.width * 0.2 * 1.5,
                      color: Colors.grey,
                      width: size.width * 0.2,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: size.width * 0.2 * 1.5,
            width: size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  movie.overview,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_half_rounded,
                      color: Colors.yellow[700],
                    ),
                    Text(movie.voteAverage.toString()),
                    Text('  (${movie.voteCount.toString()})'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
