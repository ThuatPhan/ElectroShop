import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';

abstract class ProductApiSource {
  Future<PagedModel<ProductEntity>> fetchGetProducts (int pageSize, int pageNumber);
}