import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/data/models/product_model.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/product_api_source.dart';

class ProductApiSourceImpl implements ProductApiSource{
  ApiSource apiSource;
  ProductApiSourceImpl({required this.apiSource});

  @override
  Future<PagedModel<ProductModel>> fetchGetProducts(int pageSize, int pageNumber) async  {
      return await apiSource.getPagedList<ProductModel>(
        'product?pageNumber=$pageNumber&pageSize=$pageSize',
        fromJson: (json) => ProductModel.fromJson(json),
      );
  }

  @override
  Future<ProductModel> fetchGetProduct(int productId) async{
    return await apiSource.getData<ProductModel>(
      'product/$productId',
      fromJson: (json) => ProductModel.fromJson(json),
    );
  }

  @override
  Future<List<ProductModel>> fetchGetProductOfCategory(int categoryId) async{
    return await apiSource.getList<ProductModel>(
      'Product/category/$categoryId',
      fromJson: (json) => ProductModel.fromJson(json),
    );
  }

  @override
  Future<List<ProductModel>> fetchSearchProducts(String keyword) async {
    return await apiSource.getList<ProductModel>(
      'product/search?keyword=$keyword',
      fromJson: (json) => ProductModel.fromJson(json),
    );
  }
}