import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetProducts implements UseCase<PagedModel<ProductEntity>, GetProductsParams> {
  final ProductRepository productRepository;
  GetProducts({required this.productRepository});

  @override
  Future<PagedModel<ProductEntity>> call(GetProductsParams getProductsParams) async {
    return await productRepository
        .getProducts(getProductsParams.pageNumber, getProductsParams.pageSize);
  }
}