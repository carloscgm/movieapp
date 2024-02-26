import 'dart:convert';

import 'package:movieapp/domain/entities/posterable_item.dart';
import 'package:movieapp/domain/entities/tv_entity.dart';

TvModel tvModelFromJson(String str) => TvModel.fromJson(json.decode(str));

String tvModelToJson(TvModel data) => json.encode(data.toJson());

class TvModel extends TvEntity implements PostableItem {
  @override
  final bool adult;
  @override
  final String backdropPath;
  @override
  final List<int> genreIds;
  @override
  final int id;
  @override
  final List<String> originCountry;
  @override
  final String originalLanguage;
  @override
  final String originalName;
  @override
  final String overview;
  @override
  final double popularity;
  @override
  final String posterPath;
  @override
  final DateTime? firstAirDate;
  @override
  final String name;
  @override
  final double voteAverage;
  @override
  final int voteCount;

  TvModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          genreIds: genreIds,
          id: id,
          originCountry: originCountry,
          originalLanguage: originalLanguage,
          originalName: originalName,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          firstAirDate: firstAirDate,
          name: name,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] != null
            ? 'https://image.tmdb.org/t/p/w500${json["backdrop_path"]}'
            : '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] != null
            ? 'https://image.tmdb.org/t/p/w500${json["poster_path"]}'
            : '',
        firstAirDate: json["first_air_date"] != null &&
                json["first_air_date"].toString().isNotEmpty
            ? DateTime.parse(json["first_air_date"])
            : null,
        name: json["name"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate != null
            ? "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}"
            : null,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  String get title => name;
}
