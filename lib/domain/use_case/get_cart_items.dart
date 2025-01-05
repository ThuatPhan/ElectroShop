import 'package:electro_shop/data/services/auth_service.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/domain/repositories/cart_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetCartItems implements UseCase<List<ProductItemEntity>, NoParams> {
  GetCartItems({required this.cartRepository});

  final CartRepository cartRepository;

  @override
  Future<List<ProductItemEntity>> call(NoParams params) async {
    bool isUserLoggedIn = await AuthService.instance.hasValidCredentials();
    if(!isUserLoggedIn){
      return [];
    }
    return await cartRepository.getCartItems();
  }
}
