import 'package:electro_shop/data/models/product_item_model.dart';
import 'package:electro_shop/data/services/auth_service.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/cart_api_source.dart';
import 'package:flutter/cupertino.dart';

class CartApiSourceImpl implements CartApiSource {
  ApiSource apiSource;

  CartApiSourceImpl({required this.apiSource});

  @override
  Future<ProductItemModel> fetchAddCartItem(int productId, int? variantId, int quantity) async {
    final String accessToken = await AuthService.instance.getAccessToken();
    ProductItemModel productItem = await apiSource
      .postData<ProductItemModel>(
        'cart/add-item',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: {
          "productId": productId,
          "variantId": variantId,
          "quantity": quantity
        },
        fromJson: (json) => ProductItemModel.fromJson(json),
    );
    return productItem;
  }

  @override
  Future<List<ProductItemModel>> fetchGetCartItems() async {
    final String accessToken = await AuthService.instance.getAccessToken();
    return apiSource
        .getList<ProductItemModel>(
            'cart',
            headers: {
              "Authorization": "Bearer $accessToken"
            },
            fromJson: (json) => ProductItemModel.fromJson(json)
        );
  }

  @override
  Future<int> fetchGetCartItemCount() async {
    final String accessToken = await AuthService.instance.getAccessToken();
    debugPrint(accessToken);
    return apiSource
        .getData<int>(
        'cart/count-item',
        headers: {
          "Authorization": "Bearer $accessToken"
        }
    );
  }

  @override
  Future<void> fetchUpdateCartItem(int productId, int? variantId, int quantity) async {
    final String accessToken = await AuthService.instance.getAccessToken();
    await apiSource.putData(
        'cart/update-item-quantity',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: {
          "productId": productId,
          "variantId": variantId,
          "quantity": quantity
        }
    );
  }

  @override
  Future<void> fetchDeleteCartItem(int productId, int? variantId) async {
    final String accessToken = await AuthService.instance.getAccessToken();
    await apiSource.deleteData(
        'cart/delete-item?productId=$productId${variantId != null ? '&variantId=$variantId' : ''}',
        headers: {
          "Authorization": "Bearer $accessToken",
        }
    );
  }
}
