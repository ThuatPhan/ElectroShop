import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/data/sources/network/product_api_source.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class SearchProduct implements UseCase<PagedModel<ProductEntity>, SearchProductParams> {
  SearchProduct({required this.productApiSource});

  ProductApiSource productApiSource;

  @override
  Future<PagedModel<ProductEntity>> call(SearchProductParams params) async {
    return await productApiSource.fetchSearchProducts(params.keyword, params.pageNumber, params.pageSize);
  }
}
