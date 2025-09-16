import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';
import 'package:shartflix_movie_app_case/core/utils/token.dart';

class AuthServices {
  final String baseUrl = AppStrings.baseurl;

  // login giriş yap
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 && decoded['data'] != null) {
      final userData = decoded['data'];

      // sadece token helper çağır
      await Token.saveIdToken(userData['token'] ?? "");

      // geri kalan user bilgilerini istersen prefs ile kaydet
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', userData['id'] ?? "");
      await prefs.setString('email', userData['email'] ?? "");
      await prefs.setString('name', userData['name'] ?? "");
      await prefs.setString('photoUrl', userData['photoUrl'] ?? "");

      debugPrint("Login başarılı: $userData");
      return {'success': true, 'user': userData};
    } else {
      return {
        'success': false,
        'error': decoded['response']?['message'] ?? 'Giriş başarısız',
      };
    }
  }

  // kayıt ol 
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String? photoUrl,
  ) async {
    final url = Uri.parse('$baseUrl/user/register');
    try {
      final body = {'name': name, 'email': email, 'password': password};
      if (photoUrl != null && photoUrl.isNotEmpty) {
        body['photoUrl'] = photoUrl;
      }

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      final decoded = jsonDecode(response.body);
      debugPrint('Register Response: $decoded');

      if (response.statusCode == 200 && decoded['data'] != null) {
        final userData = decoded['data'];

        // token helper ile kaydet
        await Token.saveIdToken(userData['token'] ?? "");

        // diğer bilgileri kaydet
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', userData['id'] ?? "");
        await prefs.setString('email', userData['email'] ?? "");
        await prefs.setString('name', userData['name'] ?? "");
        await prefs.setString('photoUrl', userData['photoUrl'] ?? "");

        return {
          'success': true,
          'user': userData,
          'message': decoded['response']?['message'] ?? 'Kayıt başarılı',
        };
      } else {
        return {
          'success': false,
          'error': decoded['response']?['message'] ?? 'Kayıt başarısız',
        };
      }
    } catch (e) {
      debugPrint('Register Error: $e');
      return {
        'success': false,
        'error': 'Sunucuya bağlanılamadı: ${e.toString()}',
      };
    }
  }

  // logout ekleyelim
  Future<void> logout() async {
    await Token.clearToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // tüm user bilgilerini temizle
  }

  // progili getir
  Future<Map<String, dynamic>> getProfile() async {
    final url = Uri.parse('$baseUrl/user/profile');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final userData = decoded['data'];
      return {'success': true, 'user': userData};
    } else {
      return {
        'success': false,
        'error': decoded['response']['message'] ?? 'Profil bilgisi alınamadı',
      };
    }
  }
}
