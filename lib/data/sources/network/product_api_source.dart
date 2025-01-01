import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/data/models/product_model.dart';

abstract class ProductApiSource {
  Future<PagedModel<ProductModel>> fetchGetProducts (int pageSize, int pageNumber);
  Future<ProductModel> fetchGetProduct(int productId);
  Future<PagedModel<ProductModel>> fetchGetProductOfCategory(int categoryId, int pageSize, int pageNumber);
  Future<PagedModel<ProductModel>> fetchSearchProducts(String keyword, int pageNumber, int pageSize);
}