import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/constants/app_icons.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/extensions/padding_extension.dart';
import 'package:shartflix_movie_app_case/core/extensions/theme_extension.dart';
import 'package:shartflix_movie_app_case/core/services/navigation_service.dart';
import 'package:shartflix_movie_app_case/core/widgets/shaderMaskWidget.dart';
import 'package:shartflix_movie_app_case/core/widgets/shimmer_loading.dart';
import 'package:shartflix_movie_app_case/core/widgets/bottomsheet.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_cubit.dart';
import 'package:shartflix_movie_app_case/features/auth/viewmodel/auth_state.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/favoriteMovie/favorite_movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_cubit.dart';
import 'package:shartflix_movie_app_case/features/movie/viewmodel/movie/movie_state.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_cubit.dart';
import 'package:shartflix_movie_app_case/features/photo/viewmodel/userPhoto_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AuthCubit>().fetchProfile();
    context.read<FavoriteMovieCubit>().fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: context.paddingLarge,
                child: Column(
                  spacing: 14,
                  children: [title(context), profileInformation(context)],
                ),
              ),
              Divider(
                height: 0.1,
                color: const Color.fromARGB(24, 255, 255, 255),
              ),
              favoriteMovies(),
            ],
          ),
        ],
      ),
    );
  }

  // *** FAVORITE MOVIES LIST ***
  Widget favoriteMovies() {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, movieState) {
        final favoriteState = context.watch<FavoriteMovieCubit>().state;

        // *** LOADING DURUMU ***
        if (movieState.isLoading || favoriteState.isLoading) {
          return Expanded(
            child: Padding(
              padding: context.paddingLarge,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 4, // loading için sabit shimmer sayısı
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(
                        child: ShimmerLoading(
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      ShimmerLoading(width: double.infinity, height: 20),
                      ShimmerLoading(width: 100, height: 14),
                    ],
                  );
                },
              ),
            ),
          );
        }

        // *** FAVORİLERİ MAPLE ***
        final updatedFavorites = favoriteState.favorites.map((fav) {
          return movieState.movies.firstWhere(
            (m) => m.movieId == fav.movieId,
            orElse: () => fav,
          );
        }).toList();

        // *** FAVORİ YOKSA ***
        if (updatedFavorites.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: shaderMaskWidget(
                context,
                Text(
                  'No favorite movies found.'.tr(),
                  style: context.textTheme.bodyLarge,
                ),
              ),
            ),
          );
        }

        // *** FAVORİLERİ GÖSTER ***
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 20),
                child: Text(
                  'My Favorites'.tr(),
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: AppFontFamilies.instrumentSansSemiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: context.paddingLarge,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: updatedFavorites.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 270,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,
                        ),
                    itemBuilder: (context, index) {
                      final movie = updatedFavorites[index];
                      return Column(
                        spacing: 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: movie.poster.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: movie.poster.replaceFirst(
                                        'http://',
                                        'https://',
                                      ),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const ShimmerLoading(
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(
                                                Icons.movie,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(
                                          Icons.movie,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontFamily:
                                  AppFontFamilies.instrumentSansSemiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            movie.director,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.theme.shadowColor.withAlpha(150),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // *** TITLE AND CONTAINER ***
  Row title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Profile".tr(),
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: AppFontFamilies.instrumentSansBold,
              ),
            ),
            IconButton(
              onPressed: () {
                NavigationService().navigateTo('/settings');
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showBottomSheetApp(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(56),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE50914), Color(0xFFB2040C)],
              ),
            ),
            child: Row(
              spacing: 5,
              children: [
                AppIcons.icon(AppIcons.gem, size: 20, color: Colors.white),
                Text(
                  "Limited Offer".tr(),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontFamily: AppFontFamilies.instrumentSansSemiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // *** PROFILE BİLGİLERİ ***
  Widget profileInformation(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, photoState) {
            final isUploading = photoState is PhotoUploading;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Kullanıcı bilgisi ve fotoğraf
                Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // FOTOĞRAF
                    (authState.user?.photoUrl == null || isUploading)
                        ? const ShimmerLoading(
                            width: 50,
                            height: 50,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          )
                        : CircleAvatar(
                            radius: 25,
                            backgroundColor: context.theme.primaryColor,
                            backgroundImage:
                                authState.user!.photoUrl!.isNotEmpty
                                ? NetworkImage(
                                    "${authState.user!.photoUrl}?v=${DateTime.now().millisecondsSinceEpoch}",
                                  )
                                : null,
                            child: authState.user!.photoUrl!.isEmpty
                                ? AppIcons.icon(
                                    AppIcons.profileFill,
                                    color: Colors.white,
                                  )
                                : null,
                          ),

                    // KULLANICI BİLGİSİ
                    (authState.user == null || isUploading)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: const [
                              ShimmerLoading(
                                width: 100,
                                height: 16,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              ShimmerLoading(
                                width: 80,
                                height: 14,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            width: 30.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                Text(
                                  authState.user?.name ?? "User".tr(),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        AppFontFamilies.instrumentSansMedium,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "ID: ${authState.user?.id ?? 'null'.tr()}",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontFamily:
                                        AppFontFamilies.instrumentSansMedium,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(
                                      context,
                                    ).shadowColor.withAlpha(150),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),

                // FOTOĞRAF EKLE BUTONU
                GestureDetector(
                  onTap: () async {
                    final photoCubit = context.read<PhotoCubit>();
                    final authCubit = context.read<AuthCubit>();
                    final source = await showModalBottomSheet<ImageSource>(
                      context: context,
                      builder: (_) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: Text(
                              'Camera'.tr(),
                              style: context.textTheme.bodyLarge,
                            ),
                            onTap: () =>
                                Navigator.pop(context, ImageSource.camera),
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: Text(
                              'Select from Gallery'.tr(),
                              style: context.textTheme.bodyLarge,
                            ),
                            onTap: () =>
                                Navigator.pop(context, ImageSource.gallery),
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    );

                    if (source != null) {
                      final pickedFile = await ImagePicker().pickImage(
                        source: source,
                        imageQuality: 70,
                      );

                      if (pickedFile != null) {
                        final file = File(pickedFile.path);

                        // Fotoğrafı backend'e yükle
                        await photoCubit.uploadPhoto(file);

                        // Upload tamamlandıktan sonra AuthCubit user state'ini güncelle
                        if (photoCubit.state is PhotoSuccess) {
                          final uploadedUser =
                              (photoCubit.state as PhotoSuccess).user;
                          final currentUser = authCubit.state.user;

                          if (currentUser != null) {
                            final updatedUser = currentUser.copyWith(
                              photoUrl: uploadedUser
                                  .photoUrl, // sadece fotoğrafı değiştir
                            );

                            authCubit.emit(
                              authCubit.state.copyWith(user: updatedUser),
                            );
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 19,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(40),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Add Photo".tr(),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: AppFontFamilies.instrumentSansSemiBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
