import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/utils/update_poster_url.dart';
import 'package:shartflix_movie_app_case/core/widgets/movie/like_button.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieCubit>().fetchMoviesByPage(reset: true);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        color: context.theme.shadowColor,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        springAnimationDurationInMilliseconds: 100,
        showChildOpacityTransition: true,
        onRefresh: () async {
          context.read<MovieCubit>().reset();
          await context.read<MovieCubit>().fetchMoviesByPage(reset: true);
        },
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state.error != null && state.movies.isEmpty) {
              return Center(
                child: Text(
                  'Hata: ${state.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            final movies = state.movies;

            if (movies.isEmpty && !state.isLoading) {
              return Center(
                child: Text(
                  "Film bulunamadı",
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }

            return Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.hasReachedMax
                      ? movies.length
                      : movies.length + 2,
                  onPageChanged: (index) {
                    final cubit = context.read<MovieCubit>();
                    final state = cubit.state;

                    if (index >= movies.length - 1 &&
                        !state.hasReachedMax &&
                        !state.isPageLoading &&
                        !state.isLoading) {
                      cubit.fetchMoviesByPage();
                    }
                  },
                  itemBuilder: (context, index) {
                    if (index >= movies.length - 1) {
                      return state.isPageLoading
                          ? Center(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CircularProgressIndicator(
                                  color: context.theme.shadowColor,
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }

                    final movie = movies[index];
                    final posterUrl = movie.poster.isNotEmpty
                        ? UpdatePosterurl.upgradePosterUrl(
                            movie.poster,
                            width: 1000,
                          )
                        : '';

                    return Stack(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: Image.network(
                            posterUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.white.withOpacity(0.4),
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 60,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        topOpacity(),
                        Positioned(
                          bottom: 20,
                          left: 25,
                          right: 25,
                          child: Row(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image.asset(AppImages.logo_circle),
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontFamily: AppFontFamilies
                                                .instrumentSansBold,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: movie.plot.length > 60
                                            ? '${movie.plot.substring(0, 60)}... '
                                            : movie.plot,
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                        children: [
                                          if (movie.plot.length > 60)
                                            TextSpan(
                                              text: 'Daha Fazlası',
                                              style: context
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontFamily: AppFontFamilies
                                                        .instrumentSansBold,
                                                  ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.black87,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  16,
                                                                ),
                                                          ),
                                                    ),
                                                    builder: (_) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            16.0,
                                                          ),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              movie.title,
                                                              style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              movie.plot,
                                                              style:
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white70,
                                                                    height: 1.5,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                            ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        LikeButton(movie: movie, screenSize: Size(5.w, 20.h)),
                      ],
                    );
                  },
                ),
                if (movies.isEmpty)
                  Center(
                    child: CircularProgressIndicator(
                      color: context.theme.shadowColor,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container topOpacity() {
    return Container(
      height: 20.h,
      width: double.infinity,
      color: Colors.black.withOpacity(0.9),
    );
  }
}
