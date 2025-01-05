import 'package:electro_shop/data/models/product_item_model.dart';

abstract class CartApiSource{
  Future<ProductItemModel> fetchAddCartItem(int productId, int? variantId, int quantity);
  Future<List<ProductItemModel>> fetchGetCartItems();
  Future<int> fetchGetCartItemCount();
  Future<void> fetchUpdateCartItem(int productId, int? variantId, int quantity);
  Future<void> fetchDeleteCartItem(int productId, int? variantId);
}