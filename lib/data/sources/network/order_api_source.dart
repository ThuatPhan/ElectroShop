import 'package:electro_shop/data/models/order_model.dart';

abstract class OrderApiSource{
  Future<List<OrderModel>> fetchGetOrders();
}