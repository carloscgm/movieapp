import 'dart:convert';

TvDetailCastingModel tvDetailCastingModelFromJson(String str) =>
    TvDetailCastingModel.fromJson(json.decode(str));

String tvDetailCastingModelToJson(TvDetailCastingModel data) =>
    json.encode(data.toJson());

class TvDetailCastingModel {
  final List<Cast> cast;
  final List<Cast> crew;
  final int id;

  TvDetailCastingModel({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory TvDetailCastingModel.fromJson(Map<String, dynamic> json) =>
      TvDetailCastingModel(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "id": id,
      };
}

class Cast {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Role>? roles;
  final int totalEpisodeCount;
  final int? order;
  final List<Job>? jobs;
  final String? department;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.roles,
    required this.totalEpisodeCount,
    this.order,
    this.jobs,
    this.department,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"] != null
            ? 'https://image.tmdb.org/t/p/w500${json["profile_path"]}'
            : '',
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        totalEpisodeCount: json["total_episode_count"],
        order: json["order"],
        jobs: json["jobs"] == null
            ? []
            : List<Job>.from(json["jobs"]!.map((x) => Job.fromJson(x))),
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "total_episode_count": totalEpisodeCount,
        "order": order,
        "jobs": jobs == null
            ? []
            : List<dynamic>.from(jobs!.map((x) => x.toJson())),
        "department": department,
      };
}

class Job {
  final String creditId;
  final String job;
  final int episodeCount;

  Job({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        creditId: json["credit_id"],
        job: json["job"],
        episodeCount: json["episode_count"],
      );

  Map<String, dynamic> toJson() => {
        "credit_id": creditId,
        "job": job,
        "episode_count": episodeCount,
      };
}

class Role {
  final String creditId;
  final String character;
  final int episodeCount;

  Role({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        creditId: json["credit_id"],
        character: json["character"],
        episodeCount: json["episode_count"],
      );

  Map<String, dynamic> toJson() => {
        "credit_id": creditId,
        "character": character,
        "episode_count": episodeCount,
      };
}
