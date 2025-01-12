import 'package:electro_shop/data/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> fetchGetOrders();
}