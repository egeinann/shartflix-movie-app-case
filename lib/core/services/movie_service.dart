import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/features/movie/model/data_model.dart';
import 'package:shartflix_movie_app_case/features/movie/model/movie_model.dart';
import '../utils/token.dart';

class MovieServices {
  final String baseUrl = AppStrings.baseurl;
  int _currentPage = 1;

  // *** FİLMLERİ ÇEK ***
  Future<Data> getMovies({bool reset = false}) async {
    if (reset) _currentPage = 1;

    final token = await Token.getIdToken();
    print("Fetching movies from page $_currentPage");

    final response = await http.get(
      Uri.parse("$baseUrl/movie/list?page=$_currentPage"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      // pagination verisini al
      final pagination = decoded['data']['pagination'];
      final currentPage = pagination['currentPage'];
      final maxPage = pagination['maxPage'];

      // son sayfaya gelindiyse tekrar 1. sayfadan başla
      if (currentPage >= maxPage) {
        _currentPage = 1;
      } else {
      _currentPage++;
      }

      return Data.fromJson(decoded['data']);
    } else {
      throw Exception("Filmler alınamadı");
    }
  }

  // *** BEĞENİLEN FİLMLER ***
  Future<void> toggleFavorite(String movieId) async {
    final token = await Token.getIdToken();

    final response = await http.post(
      Uri.parse("$baseUrl/movie/favorite/$movieId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      throw Exception("Favori işlemi başarısız");
    }
  }

  // *** FAVORİ FİLMLER ***
  Future<List<Movie>> getFavoriteMovies() async {
    final token = await Token.getIdToken();

    final response = await http.get(
      Uri.parse("$baseUrl/movie/favorites"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final movies = (decoded['data'] as List<dynamic>)
          .map((m) => Movie.fromJson(m))
          .toList();
      return movies;
    } else {
      throw Exception("Favori filmler alınamadı");
    }
  }
}
