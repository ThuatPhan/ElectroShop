import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<PagedModel<ProductEntity>> getProducts (int pageNumber, int pageSize);
  Future<ProductEntity> getProduct(int productId);
  Future<List<ProductEntity>> getProductOfCategory(int categoryId);
  Future<List<ProductEntity>> searchProducts(String keyword);
}