import 'package:electro_shop/domain/repositories/cart_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class AddCartItem implements UseCase<void, AddCartItemParams> {
  final CartRepository cartRepository;
  AddCartItem({required this.cartRepository});

  @override
  Future<void> call(AddCartItemParams params) async {
    await cartRepository.addCartItem(params.productId, params.variantId, params.quantity);
  }
}