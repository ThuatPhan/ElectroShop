import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetProduct implements UseCase<ProductEntity,GetProductParams> {
  ProductRepository productRepository;
  GetProduct({required this.productRepository});
  
  @override
  Future<ProductEntity> call(GetProductParams getProductParams) async{
    return await productRepository.getProduct(getProductParams.id);
  }

}