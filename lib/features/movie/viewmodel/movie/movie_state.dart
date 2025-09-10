import 'package:shartflix_movie_app_case/features/movie/model/movie_model.dart';


class MovieState {  
  final List<Movie> movies;
  final bool isLoading;
  final bool isPageLoading;
  final bool hasReachedMax;
  final int nextPage;
  final String? error;

  const MovieState({
    this.movies = const [],
    this.isLoading = false,
    this.isPageLoading = false,
    this.hasReachedMax = false,
    this.nextPage = 1,
    this.error,
  });

  factory MovieState.initial() => const MovieState();

  MovieState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    bool? isPageLoading,
    bool? hasReachedMax,
    int? nextPage,
    String? error,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      nextPage: nextPage ?? this.nextPage,
      error: error,
    );
  }
}