import 'package:electro_shop/domain/repositories/cart_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class DeleteCartItem implements UseCase<void, DeleteCartItemParams> {
  DeleteCartItem({required this.cartRepository});
  final CartRepository cartRepository;

  @override
  Future<int> call(DeleteCartItemParams params) async {
    await cartRepository.deleteCartItem(params.productId, params.variantId);
    return await cartRepository.getCartItemCount();
  }
}