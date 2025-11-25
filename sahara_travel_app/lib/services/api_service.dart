import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConfig {
  /// Update this value when switching between localhost and LAN IP testing.
  /// For Chrome/Web: 'http://localhost:6000/api' or 'http://127.0.0.1:6000/api'
  /// For mobile device: 'http://10.10.8.154:6000/api'
  /// For Android emulator: 'http://10.0.2.2:6000/api'
  static String baseUrl = 'http://192.168.1.70:8080/api';
}

class ApiService {
  ApiService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? ApiConfig.baseUrl;

  final http.Client _client;
  final String _baseUrl;

  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final response = await _post(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    return AuthUser.fromJson(response);
  }

  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
    String? bio,
  }) async {
    final response = await _post(
      '/auth/register',
      body: {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        'phone': phone ?? '',
        'bio': bio ?? '',
      },
    );
    return AuthUser.fromJson(response);
  }

  Future<Map<String, dynamic>> _post(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final uri = Uri.parse('$_baseUrl$path');

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final decoded = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded as Map<String, dynamic>;
    }

    final message = decoded is Map<String, dynamic> && decoded['message'] != null
        ? decoded['message'].toString()
        : 'Request failed (${response.statusCode})';
    throw ApiException(message);
  }
}

class AuthUser {
  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
    this.phone,
    this.bio,
    this.avatarUrl,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? 'user',
      token: json['token']?.toString() ?? '',
      phone: json['phone']?.toString(),
      bio: json['bio']?.toString(),
      avatarUrl: json['avatarUrl']?.toString(),
    );
  }

  final String id;
  final String name;
  final String email;
  final String role;
  final String token;
  final String? phone;
  final String? bio;
  final String? avatarUrl;
}

class ApiException implements Exception {
  ApiException(this.message);
  final String message;

  @override
  String toString() => 'ApiException: $message';
}

