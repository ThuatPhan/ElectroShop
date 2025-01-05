import 'package:electro_shop/data/sources/network/cart_api_source.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository{
  CartApiSource cartApiSource;
  CartRepositoryImpl({required this.cartApiSource});

  @override
  Future<ProductItemEntity> addCartItem (int productId, int? variantId, int quantity) async {
    return await cartApiSource.fetchAddCartItem(productId, variantId, quantity);
  }

  @override
  Future<List<ProductItemEntity>> getCartItems() async  {
    return await cartApiSource.fetchGetCartItems();
  }

  @override
  Future<int> getCartItemCount() async  {
    return await cartApiSource.fetchGetCartItemCount();
  }

  @override
  Future<void> updateCartItem(int productId, int? variantId, int quantity) async {
    await cartApiSource.fetchUpdateCartItem(productId, variantId, quantity);
  }

  @override
  Future<void> deleteCartItem(int productId, int? variantId) async  {
    await cartApiSource.fetchDeleteCartItem(productId, variantId);
  }
}