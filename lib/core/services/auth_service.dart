import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';

class AuthServices {
  final String baseUrl = AppStrings.baseurl;
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', userData['id'] ?? "");
      await prefs.setString('token', userData['token'] ?? "");
      await prefs.setString('email', userData['email'] ?? "");
      await prefs.setString('name', userData['name'] ?? "");
      await prefs.setString('photoUrl', userData['photoUrl'] ?? "");
      debugPrint(response.body);
      return {'success': true, 'user': userData};
    } else {
      return {
        'success': false,
        'error': decoded['response']?['message'] ?? 'Giriş başarısız'
      };
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/user/register');
    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(
                {'name': name, 'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      final decoded = jsonDecode(response.body);
      debugPrint('Register Response: $decoded');

      if (response.statusCode == 200 && decoded['data'] != null) {
        final userData = decoded['data'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', userData['id'] ?? "");
        await prefs.setString('token', userData['token'] ?? "");
        await prefs.setString('email', userData['email'] ?? "");
        await prefs.setString('name', userData['name'] ?? "");
        await prefs.setString('photoUrl', userData['photoUrl'] ?? "");

        return {
          'success': true,
          'user': userData,
          'message': decoded['response']?['message'] ?? 'Kayıt başarılı'
        };
      } else {
        return {
          'success': false,
          'error': decoded['response']?['message'] ?? 'Kayıt başarısız'
        };
      }
    } catch (e) {
      debugPrint('Register Error: $e');
      return {
        'success': false,
        'error': 'Sunucuya bağlanılamadı: ${e.toString()}'
      };
    }
  }

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
        'error': decoded['response']['message'] ?? 'Profil bilgisi alınamadı'
      };
    }
  }
}