import 'package:badges/badges.dart' as badges;
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/products_cubit.dart';
import 'package:electro_shop/presentation/screens/profile_screen.dart';
import 'package:electro_shop/presentation/widgets/banner_widget.dart';
import 'package:electro_shop/presentation/widgets/category_section_widget.dart';
import 'package:electro_shop/presentation/widgets/product_section_widget.dart';
import 'package:electro_shop/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  late List<AppBar> _appBars;
  late List<Widget> _screens;
  final List<SalomonBottomBarItem> _bottomBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.home),
      title: const Text("Trang chủ"),
      selectedColor: Colors.green,
    ),
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.heart),
      title: const Text("Yêu thích"),
      selectedColor: Colors.green,
    ),
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.clock),
      title: const Text("Đơn đã mua"),
      selectedColor: Colors.green,
    ),
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.user),
      title: const Text("Hồ sơ"),
      selectedColor: Colors.green,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _appBars = [
      AppBar(
        backgroundColor: Colors.green,
        title: GestureDetector(
          onTap: () {},
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Giao hàng tới',
                style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    '494 Lê Văn Việt, TP. Hồ Chí Minh',
                    style: TextStyle(fontSize: titleSize, color: Colors.white),
                  ),
                  Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.white
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -15, end: -15),
                    badgeContent: const Text('3'),
                    child: const Icon(FontAwesomeIcons.cartShopping, color: Colors.white)
                )
            ),
          ),
        ],
      ),
      AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
              'Yêu thích',
              style: TextStyle(
                  fontSize: headerSize
              )
          ),
        ),
      ),
      AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
              'Lịch sử',
              style: TextStyle(
                  fontSize: headerSize
              )
          ),
        ),
      ),
      AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
              'Hồ sơ',
              style: TextStyle(
                  fontSize: headerSize
              )
          ),
        ),
      ),
    ];
    _screens = [
      RefreshIndicator(
        onRefresh: () async {
          return await GetIt.instance<ProductsCubit>()
              .getProducts(1, productPerPage, isRefresh: true);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              //Search
              SliverToBoxAdapter(
                child: SearchWidget(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              //Banner
              const SliverToBoxAdapter(
                child: BannerWidget(),
              ),
              //Category
              const SliverToBoxAdapter(
                child: CategorySectionWidget(),
              ),
              //Product
              const SliverToBoxAdapter(
                child: ProductSectionWidget(title: 'Sản phẩm'),
              ),
            ],
          ),
        ),
      ),
      const Center(
        child: Text("Yêu thích"),
      ),
      const Center(
        child: Text("Lịch sử"),
      ),
      const ProfileScreen()
    ];
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      debugPrint('Reached the end of the list');
      var cubit = GetIt.instance<ProductsCubit>();
      cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: _screens[_selectedIndex] ,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _bottomBarItems
      ),
    );
  }
}
