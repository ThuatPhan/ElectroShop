import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetProductOfCategory implements UseCase<PagedModel<ProductEntity>, GetProductOfCategoryParams> {
  ProductRepository productRepository;

  GetProductOfCategory({required this.productRepository});

 @override
  Future<PagedModel<ProductEntity>> call(
      GetProductOfCategoryParams getProductOfCategoryParams) async {
    return await productRepository.getProductOfCategory(
        getProductOfCategoryParams.categoryId,
        getProductOfCategoryParams.pageNumber,
        getProductOfCategoryParams.pageSize
    );
  }
}