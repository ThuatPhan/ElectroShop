import 'dart:convert';
import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:http/http.dart' as http;

class ApiSourceImpl implements ApiSource {
  final String baseUrl;

  ApiSourceImpl({required this.baseUrl});

  @override
  Future<T> getData<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (fromJson != null) {
        return fromJson(jsonResponse['data']);
      } else {
        return jsonResponse['data'];
      }
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Future<List<T>> getList<T>(
    String endpoint, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonList = jsonResponse['data'];
      return jsonList.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Future<PagedModel<T>> getPagedList<T>(
    String endpoint, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      int remainingItems = jsonResponse['data']['remainingItems'];
      List<dynamic> itemsJson = jsonResponse['data']['items'];
      List<T> items = itemsJson.map((item) => fromJson(item)).toList();
      return PagedModel<T>(
        remainingItems: remainingItems,
        items: items,
      );
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Future<T> postData<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      if (fromJson != null) {
        return fromJson(jsonResponse['data']);
      } else {
        throw Exception("fromJson function must be provided for type $T");
      }
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteData(
      String endpoint,
      {Map<String, String>? headers
  }) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
      if (response.statusCode != 204) {
        throw Exception("Failed to delete data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<T> putData<T>(
      String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      T Function(Map<String, dynamic>)? fromJson
  }) async {
    try {
      final response = await http.put(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
          body: jsonEncode(body)
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to update data");
      }
      var jsonResponse = await jsonDecode(response.body);
      if(fromJson != null) {
        return fromJson(jsonResponse['data']);
      }
      return jsonResponse['data'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
