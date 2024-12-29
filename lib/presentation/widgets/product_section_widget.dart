import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/products_cubit.dart';
import 'package:electro_shop/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

class ProductSectionWidget extends StatelessWidget {
  const ProductSectionWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>.value(
      value: GetIt.instance<ProductsCubit>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: headerSize, fontWeight: FontWeight.bold),
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is LoadingProducts) {
                final prevProducts = state.prevProducts ?? [];
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: prevProducts.isEmpty
                      ? 4
                      : prevProducts.length + productPerPage, // Tổng số sản phẩm + placeholder
                  itemBuilder: (context, index) {
                    if (index < prevProducts.length) {
                      return ProductWidget(product: prevProducts[index]);
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ProductsLoadSuccess) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Số cột
                    crossAxisSpacing: 10, // Khoảng cách giữa các cột
                    mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                    childAspectRatio: 3 / 4, // Tỷ lệ chiều rộng / chiều cao
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) => ProductWidget(product: state.products[index]),
                );
              } else if (state is ProductsLoadFailed) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                });
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
