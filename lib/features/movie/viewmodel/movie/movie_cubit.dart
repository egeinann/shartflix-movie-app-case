import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/core/services/movie_service.dart';

import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieServices movieServices;

  MovieCubit({required this.movieServices}) : super(MovieState.initial());

  // filmleri getir
  Future<void> fetchMoviesByPage({bool reset = false}) async {
    if (state.isPageLoading || state.isLoading) return;

    if (reset) {
      emit(
        state.copyWith(
          movies: [],
          error: null,
          hasReachedMax: false,
          isLoading: true,
          isPageLoading: true,
          nextPage: 1,
        ),
      );
    } else {
      emit(state.copyWith(isPageLoading: true, error: null));
    }

    try {
      final data = await movieServices.getMovies(reset: reset);

      final cleanedMovies = data.movies.map((movie) {
        return movie.copyWith(
          poster: movie.poster.isNotEmpty ? movie.poster : '',
        );
      }).toList();

      final movies = reset
          ? cleanedMovies
          : [...state.movies, ...cleanedMovies];

      emit(
        state.copyWith(
          movies: movies,
          // sonsuz kaydırma için artık hiçbir zaman true olmuyor
          hasReachedMax: false,
          isLoading: false,
          isPageLoading: false,
          nextPage: data.pagination.currentPage + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          isPageLoading: false,
        ),
      );
    }
  }

  // like butonu işlevi
  Future<void> toggleFavorite(String movieId) async {
    try {
      await movieServices.toggleFavorite(movieId);

      final updatedMovies = state.movies.map((m) {
        if (m.movieId == movieId) {
          return m.copyWith(isFavorite: !m.isFavorite);
        }
        return m;
      }).toList();

      emit(state.copyWith(movies: updatedMovies));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  // filmleri yenile
  void reset() {
    emit(MovieState.initial());
  }
}
