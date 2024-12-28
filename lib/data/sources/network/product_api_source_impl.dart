import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/data/models/product_model.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/product_api_source.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';

class ProductApiSourceImpl implements ProductApiSource{
  ApiSource apiSource;
  ProductApiSourceImpl({required this.apiSource});

  @override
  Future<PagedModel<ProductEntity>> fetchGetProducts(int pageSize, int pageNumber) async  {
      return await apiSource.getPagedList<ProductModel>(
        'product?pageNumber=$pageNumber&pageSize=$pageSize',
        fromJson: (json) => ProductModel.fromJson(json),
      );
  }
}