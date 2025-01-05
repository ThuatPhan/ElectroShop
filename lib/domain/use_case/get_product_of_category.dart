import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetProductOfCategory implements UseCase<List<ProductEntity>, GetProductOfCategoryParams> {
  ProductRepository productRepository;

  GetProductOfCategory({required this.productRepository});

 @override
  Future<List<ProductEntity>> call(GetProductOfCategoryParams params) async {
    return await productRepository.getProductOfCategory(
        params.categoryId
    );
  }
}