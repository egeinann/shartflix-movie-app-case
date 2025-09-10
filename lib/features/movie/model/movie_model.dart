class Movie {
  String id;
  String movieId;
  String title;
  String director;
  String plot;
  String poster;
  bool isFavorite;
  Movie({
    required this.id,
    required this.movieId,
    required this.title,
    required this.director,
    required this.plot,
    required this.poster,
    required this.isFavorite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["_id"],
        movieId: json["id"],
        title: json["Title"],
        director: json["Director"],
        plot: json["Plot"],
        poster: json["Poster"],
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": movieId,
        "Title": title,
        "Director": director,
        "Plot": plot,
        "Poster": poster,
        "isFavorite": isFavorite,
      };

  Movie copyWith({
    String? id,
    String? movieId,
    String? title,
    String? director,
    String? plot,
    String? poster,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      movieId: movieId ?? this.movieId,
      title: title ?? this.title,
      director: director ?? this.director,
      plot: plot ?? this.plot,
      poster: poster ?? this.poster,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}