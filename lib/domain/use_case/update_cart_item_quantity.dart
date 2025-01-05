import 'package:electro_shop/domain/repositories/cart_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class UpdateCartItem extends UseCase<void, UpdateCartItemParams> {
  UpdateCartItem({required this.cartRepository});
  CartRepository cartRepository;

  @override
  Future<void> call(UpdateCartItemParams params) async {
    await cartRepository.updateCartItem(params.productId, params.variantId, params.quantity);
  }

}