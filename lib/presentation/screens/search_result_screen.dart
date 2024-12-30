import 'package:badges/badges.dart' as badges;

import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/search_product_cubit.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:electro_shop/presentation/widgets/product_widget.dart';
import 'package:electro_shop/presentation/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final ScrollController _scrollController = ScrollController();
  late String _keyword;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      debugPrint('Reached the end of the list');
      var cubit = GetIt.instance<SearchProductCubit>();
      await cubit.loadMore(_keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String keyword = args['keyword']!;
    setState(() {
      _keyword = keyword;
    });
    return Scaffold(
      appBar: AppBar(
        title: const SearchBox(),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -15, end: -15),
                  badgeContent: const Text('3'),
                  child: Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) {
                      return Icon(
                        FontAwesomeIcons.cartShopping,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      );
                    },
                  ),
                )
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Text("Kết quả tìm kiếm cho \"$keyword\""),
            ),
            SliverToBoxAdapter(
              child: BlocProvider(
                create: (context) => GetIt.instance<SearchProductCubit>()
                  ..searchProducts(keyword, 1, productPerPage),
                child: BlocBuilder<SearchProductCubit, SearchProductState>(
                  builder: (context, state) {
                    if(state is SearchingProduct) {
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
                            ? productPerPage
                            : prevProducts.length + productPerPage,
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

