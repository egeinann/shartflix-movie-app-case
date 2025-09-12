import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/features/movie/model/movie_model.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/favoriteMovie/favorite_movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_state.dart';

class FavouriteMovie extends StatelessWidget {
  final List<Movie> favorites;

  const FavouriteMovie({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(
        child: Text(
          'Favorite movie not found.'.tr(),
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return BlocBuilder<MovieCubit, MovieState>(
  builder: (context, movieState) {
    final favoriteState = context.watch<FavoriteMovieCubit>().state;

    // Güncel favori filmler
    final updatedFavorites = favoriteState.favorites.map((fav) {
      return movieState.movies.firstWhere(
        (m) => m.movieId == fav.movieId,
        orElse: () => fav,
      );
    }).toList();

    if (updatedFavorites.isEmpty) {
          return Center(
        child: Text(
              'Favorite movie not found.'.tr(),
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: updatedFavorites.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final movie = updatedFavorites[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie.poster.isNotEmpty
                          ? movie.poster
                          : 'https://via.placeholder.com/300x450?text=No+Image',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  movie.director,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  },
);
  }
}
