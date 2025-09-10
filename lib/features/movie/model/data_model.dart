import 'pagination.dart';
import 'movie_model.dart';

class Data {
  List<Movie> movies;
  Pagination pagination;

  Data({
    required this.movies,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        movies: List<Movie>.from(
          json["movies"].map((x) => Movie.fromJson(x)),
        ),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}