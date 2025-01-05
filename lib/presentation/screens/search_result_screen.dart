import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/search_product_cubit.dart';
import 'package:electro_shop/presentation/widgets/cart_icon_widget.dart';
import 'package:electro_shop/presentation/widgets/product_widget.dart';
import 'package:electro_shop/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    String keyword = args['keyword']!;

    return Scaffold(
      appBar: AppBar(
        title: const SearchBox(),
        actions: const [
          CartIconWidget()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text("Kết quả tìm kiếm cho \"$keyword\""),
            ),
            SliverToBoxAdapter(
              child: BlocProvider(
                create: (context) => GetIt.instance<SearchProductCubit>()
                  ..searchProducts(keyword),
                child: BlocBuilder<SearchProductCubit, SearchProductState>(
                  builder: (context, state) {
                    if(state is SearchingProduct) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: productPerPage,
                        itemBuilder: (context, index) {
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
                    }
                    if (state is SearchProductSuccess) {
                      if(state.products.isEmpty) {
                        if (context.mounted) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Không tìm thấy sản phẩm phù hợp với từ khoá \"$keyword\""),
                              ),
                            );
                          });
                          return Container();
                        }
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductWidget(product: product);
                        },
                      );
                    }
                    if(state is SearchProductFailed) {
                      if(context.mounted) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message))
                          );
                        });
                      }
                    }
                    return Container();
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

