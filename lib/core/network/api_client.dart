import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

/// Cliente HTTP fino, preparado para o consumo da API própria do PULSO
/// (gestão de treinos, aulas, assinaturas etc.). Ainda não utilizado por
/// nenhum serviço — fica pronto para quando o backend estiver disponível.
class ApiClient {
  final http.Client _client;
  final String baseUrl;

  ApiClient({http.Client? client, this.baseUrl = AppConstants.apiBaseUrl})
      : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String path, {String? token}) async {
    final response = await _client
        .get(Uri.parse('$baseUrl$path'), headers: _headers(token))
        .timeout(AppConstants.networkTimeout);
    return _decode(response);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await _client
        .post(
          Uri.parse('$baseUrl$path'),
          headers: _headers(token),
          body: jsonEncode(body),
        )
        .timeout(AppConstants.networkTimeout);
    return _decode(response);
  }

  Map<String, String> _headers(String? token) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Map<String, dynamic> _decode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw NetworkException(
        'Erro na requisição (${response.statusCode})',
      );
    }
    if (response.body.isEmpty) return {};
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
