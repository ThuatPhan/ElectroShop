import 'package:electro_shop/presentation/bloc/order_cubit.dart';
import 'package:electro_shop/presentation/widgets/purchase_history_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng đã mua'),
      ),
      body: BlocProvider(
        create: (context) => GetIt.instance<OrderCubit>(),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if(state is LoadingOrders){
              return const Center(child: CircularProgressIndicator());
            }
            if(state is OrderLoadSuccess) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) =>  PurchaseHistoryItemWidget(orderEntity: state.orders[index]),
                  )
                ],
              );
            }
            if(state is OrderLoadFailed){
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },

        ),
      )
    );
  }
}
