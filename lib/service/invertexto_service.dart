import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class InvertextoService {
  final String _token = "21567|3pIjBHMOxbPqSemOC90q18RypX6llWZS";

  Future<Map<String, dynamic>> ConvertePorExtenso(
      String? valor, String? currency) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/number-to-words?token=${_token}&value=${valor}&language=pt&currency=${currency}",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCEP(String? valor) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/cep/${valor}?token=${_token}",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getFipeBrands(int type) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/fipe/brands/${type}?token=${_token}",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getFipeModels(int brandId) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/fipe/models/${brandId}?token=${_token}",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getFipeYears(String fipeCode) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/fipe/years/${fipeCode}?token=${_token}",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getFipePrice(
      String fipeCode, String yearId) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/fipe/history?token=${_token}&fipe_code=${fipeCode}&year_id=${yearId}",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }
}