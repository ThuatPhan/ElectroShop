import 'package:electro_shop/domain/entities/order_entity.dart';
import 'package:electro_shop/domain/use_case/get_orders.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OrderState {}

class LoadingOrders extends OrderState {}

class OrderLoadSuccess extends OrderState {
  final List<OrderEntity> orders;

  OrderLoadSuccess({required this.orders});
}

class OrderLoadFailed extends OrderState {
  final String message;

  OrderLoadFailed({required this.message});
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.useCase}) : super(LoadingOrders());
  final GetOrders useCase;

  Future<void> getOrders() async {
    try {
      emit(LoadingOrders());
      List<OrderEntity> orders = await useCase.call(NoParams());
      emit(OrderLoadSuccess(orders: orders));
    } catch (e) {
      emit(OrderLoadFailed(message: e.toString()));
    }
  }
}
