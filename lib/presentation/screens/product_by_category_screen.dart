import 'package:badges/badges.dart' as badges;
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/product_of_category_cubit.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:electro_shop/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductByCategoryScreen extends StatefulWidget {
  const ProductByCategoryScreen({super.key});

  @override
  State<ProductByCategoryScreen> createState() => _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  late int _categoryId;

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      var cubit = GetIt.instance<ProductOfCategoryCubit>();
      cubit.loadMore(_categoryId);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int categoryId = args['categoryId']!;
    _categoryId = categoryId;
    debugPrint('$categoryId');
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Danh mục sản phẩm',
            style: TextStyle(fontSize: headerSize),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
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
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => GetIt.instance<ProductOfCategoryCubit>()
          ..getProductOfCategory(categoryId, 1, productPerPage),
        child: BlocBuilder<ProductOfCategoryCubit, ProductOfCategoryState>(
          builder: (context, state) {
            if (state is LoadingProductOfCategory) {
              final prevProducts = state.prevProducts ?? [];
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
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
                        childCount: prevProducts.length + productPerPage,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProductOfCategoryLoadSuccess) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) =>
                            ProductWidget(product: state.products[index]),
                        childCount: state.products.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProductOfCategoryLoadFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            debugPrint('Unexpected state: $state');
            return Container();
          },
        ),
      ),
    );
  }
}