import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/core/services/movie_service.dart';
import 'package:shartflix_movie_app_case/core/utils/update_poster_url.dart';

import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieServices movieServices;

  MovieCubit({required this.movieServices}) : super(MovieState.initial());

Future<void> fetchMoviesByPage({bool reset = false}) async {
  if (state.isPageLoading || state.isLoading || state.hasReachedMax) return;

  if (reset) {
    emit(state.copyWith(
      movies: [],
      error: null,
      hasReachedMax: false,
      isLoading: true,
      isPageLoading: true,
      nextPage: 1,
    ));
  } else {
    emit(state.copyWith(isPageLoading: true, error: null));
  }

  try {
    final data = await movieServices.getMovies(reset: reset);
    final cleanedMovies = data.movies.map((movie) {
      final updatedPoster = movie.poster.isNotEmpty
          ? UpdatePosterurl.upgradePosterUrl(movie.poster, width: 1000)
          : '';
      return movie.copyWith(poster: updatedPoster);
    }).toList();

    final movies = reset ? cleanedMovies : [...state.movies, ...cleanedMovies];

    emit(state.copyWith(
      movies: movies,
      hasReachedMax: data.pagination.currentPage >= data.pagination.maxPage,
      isLoading: false,
      isPageLoading: false,
      nextPage: data.pagination.currentPage + 1,
    ));
  } catch (e) {
    emit(state.copyWith(
      error: e.toString(),
      isLoading: false,
      isPageLoading: false,
    ));
  }
}

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

  void reset() {
    emit(MovieState.initial());
  }
}