import 'package:electro_shop/domain/use_case/add_cart_item.dart';
import 'package:electro_shop/domain/use_case/delete_cart_item.dart';
import 'package:electro_shop/domain/use_case/update_cart_item_quantity.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:electro_shop/presentation/bloc/cart_item_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class CartState {}

class CartInitial extends CartState {}


class ProcessCartItemFailed extends CartState {
  final String message;
  ProcessCartItemFailed({required this.message});
}


class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.addCartItemUseCase,
    required this.updateCartItemUseCase,
    required this.deleteCartItemUseCase
  }) : super(CartInitial());

  final AddCartItem addCartItemUseCase;
  final UpdateCartItem updateCartItemUseCase;
  final DeleteCartItem deleteCartItemUseCase;

  Future<void> addCartItem (int productId, int? variantId, int quantity) async {
    try {
      await addCartItemUseCase.call(
          AddCartItemParams(productId: productId,variantId: variantId, quantity: quantity)
      );

      GetIt.instance<CartItemCubit>().getCartItems();
    } catch (e) {
      emit(ProcessCartItemFailed(message: e.toString()));
    }
  }

  Future<void> updateCartItem(int productId, int? variantId, int quantity) async {
    try {
      await updateCartItemUseCase.call(
        UpdateCartItemParams(productId: productId, variantId: variantId, quantity: quantity)
      );
      GetIt.instance<CartItemCubit>().getCartItems();
    } catch (e) {
      emit(ProcessCartItemFailed(message: e.toString()));
    }
  }

  Future<void> deleteCartItem(int productId, int? variantId) async {
     try {
       await deleteCartItemUseCase.call(
           DeleteCartItemParams(productId: productId, variantId: variantId)
       );
       GetIt.instance<CartItemCubit>().getCartItems();
     } catch (e) {
       emit(ProcessCartItemFailed(message: e.toString()));
     }
  }
}
