import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration _timeout = Duration(seconds: 15);

  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection');
    } on HttpException {
      throw ApiException('HTTP error occurred');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);

      case 400:
        throw ApiException('Bad request');

      case 401:
        throw ApiException('Unauthorized');

      case 403:
        throw ApiException('Forbidden');

      case 404:
        throw ApiException('Not found');

      case 500:
        throw ApiException('Internal server error');

      default:
        throw ApiException(
          'Request failed with status: ${response.statusCode}',
        );
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
