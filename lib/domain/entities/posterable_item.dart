abstract interface class PostableItem {
  final int id;
  final double voteAverage;
  final String posterPath;
  final String backdropPath;
  final String title;

  PostableItem(this.backdropPath,
      {required this.id,
      required this.voteAverage,
      required this.posterPath,
      required this.title});
}
