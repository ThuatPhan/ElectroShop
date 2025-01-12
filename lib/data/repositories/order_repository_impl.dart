import 'package:electro_shop/data/models/order_model.dart';
import 'package:electro_shop/data/sources/network/order_api_source.dart';
import 'package:electro_shop/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository{
  final OrderApiSource orderApiSource;
  OrderRepositoryImpl({required this.orderApiSource});
  @override
  Future<List<OrderModel>> fetchGetOrders() async{
   return await orderApiSource.fetchGetOrders();
  }

}