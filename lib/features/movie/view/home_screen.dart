import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/images.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/widgets/loading_lottie.dart';
import 'package:shartflix_movie_app_case/core/widgets/movie/like_button.dart';
import 'package:shartflix_movie_app_case/features/movie/model/movie_model.dart';
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
                      : movies.length + 1, // son index -> loading göstergesi
                  onPageChanged: (index) {
                    if (index >= movies.length - 1 &&
                        !state.hasReachedMax &&
                        !state.isPageLoading &&
                        !state.isLoading) {
                      // yeni 5 film fetch
                      context.read<MovieCubit>().fetchMoviesByPage();
                    }
                  },
                  itemBuilder: (context, index) {
                    if (index >= movies.length) {
                      return Center(child: loadingLottie());
                    }

                    final movie = movies[index];
                    final posterUrl = movie.poster.isNotEmpty
                        ? movie.poster.replaceFirst('http://', 'https://')
                        : '';
                    print('Poster URL: $posterUrl');
                    return Stack(
                      children: [
                        movieImage(movie),
                        topOpacity(),
                        bottomOpacity(),
                        Positioned(
                          bottom: 120,
                          left: 25,
                          right: 25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              LikeButton(
                                movie: movie,
                                screenSize: Size(5.w, 20.h),
                              ),
                              Row(
                                spacing: 15,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(AppImages.logo_circle),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        movieTitle(movie, context),
                                        movieDescription(movie, context),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                if (movies.isEmpty) Center(child: loadingLottie()),
              ],
            );
          },
        ),
      ),
    );
  }

  // *** MOVIE DESCRIPTION ***
  Widget movieDescription(Movie movie, BuildContext context) {
    bool isExpanded = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Text.rich(
            TextSpan(
              text: isExpanded || movie.plot.length <= 60
                  ? movie.plot
                  : '${movie.plot.substring(0, 60)}... ',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.textTheme.headlineMedium?.color?.withAlpha(150),
              ),
              children: [
                if (movie.plot.length > 60)
                  TextSpan(
                    text: isExpanded ? ' Daha Az' : ' Daha Fazlası',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontFamily: AppFontFamilies.instrumentSansBold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                  ),
              ],
            ),
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        );
      },
    );
  }

  // *** MOVIE TITLE ***
  Text movieTitle(Movie movie, BuildContext context) {
    return Text(
      movie.title,
      style: context.textTheme.headlineLarge?.copyWith(
        fontFamily: AppFontFamilies.instrumentSansBold,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // *** MOVIE IMAGE ***
  SizedBox movieImage(Movie movie) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: movie.poster.isNotEmpty
            ? movie.poster.replaceFirst('http://', 'https://')
            : '',
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          color: Colors.white.withAlpha(100),
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey, size: 60),
          ),
        ),
      ),
    );
  }

  // *** TOP OPACITY ***
  Container topOpacity() {
    return Container(
      height: 20.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black.withAlpha(0)],
        ),
      ),
    );
  }

  // *** BOTTOM OPACITY ***
  Widget bottomOpacity() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.black, Colors.black.withAlpha(0)],
          ),
        ),
      ),
    );
  }
}
