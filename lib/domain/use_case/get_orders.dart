import 'package:electro_shop/data/models/order_model.dart';
import 'package:electro_shop/domain/entities/order_entity.dart';
import 'package:electro_shop/domain/repositories/order_repository.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';

class GetOrders implements UseCase<List<OrderEntity>, NoParams> {
  OrderRepository orderRepository;
  GetOrders({required this.orderRepository});

  Future<List<OrderModel>> call(NoParams) async{
    return orderRepository.fetchGetOrders();
  }
}