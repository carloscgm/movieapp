import 'package:flutter/material.dart';
import 'package:movieapp/presentation/utils/widgets/movies/carrusel_title_section.dart';

class LoadingScaffoldHero extends StatelessWidget {
  final int id;
  final String title;
  final String backdropPath;
  final String posterPath;

  const LoadingScaffoldHero(
      {super.key,
      required this.id,
      required this.title,
      required this.backdropPath,
      required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CarruselAndTitle(
          id: id,
          title: title,
          backdropPath: backdropPath,
          posterPath: posterPath,
        ),
      ]),
    );
  }
}
