import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/widgets/outlined_container.dart';
import 'package:shartflix_movie_app_case/features/movie/model/movie_model.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/favoriteMovie/favorite_movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_state.dart';

class LikeButton extends StatefulWidget {
  final Movie movie;
  final Size screenSize;

  const LikeButton({
    Key? key,
    required this.movie,
    required this.screenSize,
  }) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    _tapController.forward(from: 0);
    await context.read<MovieCubit>().toggleFavorite(widget.movie.movieId);
    context.read<FavoriteMovieCubit>().fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        // MovieCubit içindeki movieList'ten bu filmin güncel halini bul
        final updatedMovie = state.movies.firstWhere(
          (m) => m.movieId == widget.movie.movieId,
          orElse: () => widget.movie,
        );

        final isFavorite = updatedMovie.isFavorite;

        return GestureDetector(
          onTap: _onTap,
          child: outlinedContainer(
            borderValue: 26,
            context,
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.3)
                  .chain(CurveTween(curve: Curves.easeOut))
                  .animate(_tapController),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Padding(
                  key: ValueKey<bool>(isFavorite),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                  child: AppIcons.icon(
                    isFavorite ? AppIcons.heartFill : AppIcons.heart,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
