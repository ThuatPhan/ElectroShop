import 'package:electro_shop/domain/entities/product_item_entity.dart';

abstract class CartRepository {
  Future<ProductItemEntity> addCartItem (int productId, int? variantId, int quantity);
  Future<List<ProductItemEntity>> getCartItems();
  Future<int> getCartItemCount();
  Future<void> updateCartItem(int productId, int? variantId, int quantity);
  Future<void> deleteCartItem(int productId, int? variantId);
}