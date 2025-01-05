import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/domain/use_case/get_cart_items.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CartItemState {}

class LoadingCartItems extends CartItemState {}

class CartItemsLoadSuccess extends CartItemState {

  final int numberOfItem;
  final List<ProductItemEntity> cartItems;
  CartItemsLoadSuccess({required this.cartItems, required this.numberOfItem});
}

class CartItemsLoadFailed extends CartItemState {
  CartItemsLoadFailed({required this.message});

  final String message;
}

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit({required this.useCase}) : super(LoadingCartItems());
  final GetCartItems useCase;

  Future<void> getCartItems () async {
    try {
      emit(LoadingCartItems());
      final cartItems = await useCase.call(NoParams());
      emit(CartItemsLoadSuccess(cartItems: cartItems, numberOfItem: cartItems.length));
    } catch (e) {
      emit(CartItemsLoadFailed(message: e.toString()));
    }
  }
}
