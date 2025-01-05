import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/data/sources/network/product_api_source.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiSource productApiSource;
  ProductRepositoryImpl({required this.productApiSource});

  @override
  Future<PagedModel<ProductEntity>> getProducts(int pageNumber, int pageSize) async {
    return await productApiSource.fetchGetProducts(pageSize, pageNumber);
  }

  @override
  Future<ProductEntity> getProduct(int productId) async{
    return await productApiSource.fetchGetProduct(productId);
  }
  @override
  Future<PagedModel<ProductEntity>> getProductOfCategory(int categoryId, int pageNumber,int pageSize) async{
    return await productApiSource.fetchGetProductOfCategory(categoryId, pageNumber, pageSize);
  }

  @override
  Future<List<ProductEntity>> searchProducts(String keyword) async {
    return await productApiSource.fetchSearchProducts(keyword);
  }
}