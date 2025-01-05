import 'package:electro_shop/data/models/paged_model.dart';

abstract class ApiSource {
  Future<T> getData<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<List<T>> getList<T>(
    String endpoint, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<PagedModel<T>> getPagedList<T>(
    String endpoint, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<T> postData<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(dynamic json)? fromJson,
  });

  Future<T> putData<T>(
      String endpoint, {
        Map<String, String>? headers,
        Map<String, dynamic>? body,
        T Function(dynamic json)? fromJson,
      });

  Future<void> deleteData(
      String endpoint, {
        Map<String, String>? headers,
      });
}
