import 'package:badges/badges.dart' as badges;
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/entities/product_item_entity.dart';
import 'package:electro_shop/domain/entities/variant_entity.dart';
import 'package:electro_shop/presentation/bloc/product_detail_cubit.dart';
import 'package:electro_shop/presentation/screens/checkout_screen.dart';
import 'package:electro_shop/presentation/utils/format_price.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  VariantEntity? _selectedVariant;
  late ProductEntity _product;
  int _currentQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int productId = args['productId']!;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Chi tiết sản phẩm',
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
        create: (context) => GetIt.instance<ProductDetailCubit>()..getProduct(productId),
        child: BlocBuilder<ProductDetailCubit,ProductDetailState>(
          builder: (context, state) {
            if(state is LoadingProduct){
              return const Center(child: CircularProgressIndicator());
            }
            if(state is ProductLoadSuccess){
              final ProductEntity product = state.productEntity;
              _product = product;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              product.image,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatPrice(product.price),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFE2E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(FontAwesomeIcons.heart),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Mô tả sản phẩm',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.description,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Phần nút button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showBottomSheet(context, variants: product.variants);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(167, 45),
                          ),
                          child: const Text(
                            'Thêm giỏ hàng',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showBottomSheet(context, variants: product.variants);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(buttonDangerColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(167, 45),
                          ),
                          child: const Text(
                            'Mua Ngay',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if(state is ProductLoadFailed){
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return Container();
          },

        ),
      ),
    );
  }

  // Hàm hiển thị Bottom Sheet
  void _showBottomSheet(BuildContext context, {List<VariantEntity>? variants}) {
    // Đặt mặc định biến thể đầu tiên nếu có
    _selectedVariant = (variants != null && variants.isNotEmpty) ? variants[0] : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Chiều cao tự động theo nội dung
                  children: [
                    // Thanh kéo
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _product.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Ảnh sản phẩm và giá
                    Row(
                      children: [
                        Image.network(
                          _selectedVariant != null ? _selectedVariant!.image : _product.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          formatPrice(_selectedVariant != null ? _selectedVariant!.price : _product.price),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if(variants != null && variants.isNotEmpty) ... [
                      const Text(
                        'Phân loại',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: variants.map((variant) {
                          return ChoiceChip(
                            label: Text(variant.optionName),
                            selected: _selectedVariant == variant,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  _selectedVariant = variant;
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      'Số lượng',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_currentQuantity > 1) {
                                _currentQuantity -= 1;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text('$_currentQuantity'),
                        IconButton(
                          onPressed:() {
                            setState(() {
                              _currentQuantity += 1;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(buttonPrimaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                        products: [
                                          ProductItemEntity(product: _product, selectedVariant: _selectedVariant),
                                        ],
                                    )
                                )
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(buttonDangerColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Mua ngay',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}
