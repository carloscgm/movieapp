import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/view/search/bloc/search_bloc.dart';
import 'package:movieapp/presentation/view/search/delegate/search_delegate_movie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchMovieDelegate());
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.mediumMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tus últimas buscadas',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchBlocState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.lastSearches.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showSearch(
                                context: context,
                                delegate: SearchMovieDelegate(),
                                query: state.lastSearches[index]);
                          },
                          child: ListTile(
                            title: Text(state.lastSearches[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
