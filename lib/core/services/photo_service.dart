import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shartflix_movie_app_case/core/constants/strings.dart';

class PhotoServices {
  final String baseUrl = AppStrings.baseurl;

  Future<Map<String, dynamic>> uploadPhoto(File file) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? ""; // tokeni getir

    final uri = Uri.parse('$baseUrl/user/upload_photo');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    try {
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      debugPrint('Upload Response: ${response.body}');

      Map<String, dynamic>? decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        return {'success': false, 'error': 'Geçersiz sunucu yanıtı'};
      }

      if (response.statusCode == 200) {
        final updatedUser = decoded?['data'];
        await prefs.setString('photoUrl', updatedUser['photoUrl'] ?? '');
        return {'success': true, 'user': updatedUser};
      } else {
        return {
          'success': false,
          'error':
              decoded?['message'] ??
              'Yükleme başarısız: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Upload Error: $e');
      return {
        'success': false,
        'error': 'Yükleme sırasında hata oluştu: ${e.toString()}',
      };
    }
  }
}
