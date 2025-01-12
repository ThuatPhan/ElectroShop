import 'package:electro_shop/data/models/order_model.dart';
import 'package:electro_shop/data/services/auth_service.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/order_api_source.dart';

class OrderApiSourceImpl implements OrderApiSource{
  ApiSource apiSource;

  OrderApiSourceImpl({required this.apiSource});

  @override
  Future<List<OrderModel>> fetchGetOrders() async {
    final String accessToken = await AuthService.instance.getAccessToken();
    return await apiSource.getList<OrderModel>(
      'Order',
      headers: {"Authorization": "Bearer $accessToken"},
      fromJson: (json) => OrderModel.fromJson(json),
    );
  }
}
