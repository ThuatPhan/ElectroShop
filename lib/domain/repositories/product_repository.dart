import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<PagedModel<ProductEntity>> getProducts (int pageNumber, int pageSize);
  Future<ProductEntity> getProduct(int productId);
  Future<PagedModel<ProductEntity>> getProductOfCategory(int categoryId, int pageNumber, int pageSize);
  Future<List<ProductEntity>> searchProducts(String keyword);
}