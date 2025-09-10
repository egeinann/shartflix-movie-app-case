import 'package:equatable/equatable.dart';
import 'package:shartflix_movie_app_case/features/movie/model/movie_model.dart';

class FavoriteMovieState extends Equatable {
  final List<Movie> favorites;
  final bool isLoading;
  final String? error;

  const FavoriteMovieState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
  });

  FavoriteMovieState copyWith({
    List<Movie>? favorites,
    bool? isLoading,
    String? error,
  }) {
    return FavoriteMovieState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [favorites, isLoading, error];
}