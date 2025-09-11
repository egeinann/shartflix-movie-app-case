import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/core/services/movie_service.dart';
import 'favorite_movie_state.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> {
  final MovieServices movieServices;

  FavoriteMovieCubit({required this.movieServices})
      : super(const FavoriteMovieState());

  Future<void> fetchFavorites() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final favorites = await movieServices.getFavoriteMovies();
  
      emit(state.copyWith(favorites: favorites, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}