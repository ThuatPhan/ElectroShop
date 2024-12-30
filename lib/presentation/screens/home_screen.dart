import 'package:badges/badges.dart' as badges;
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/products_cubit.dart';
import 'package:electro_shop/presentation/screens/profile_screen.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:electro_shop/presentation/widgets/banner_widget.dart';
import 'package:electro_shop/presentation/widgets/category_section_widget.dart';
import 'package:electro_shop/presentation/widgets/product_section_widget.dart';
import 'package:electro_shop/presentation/widgets/ship_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
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
      icon: const Icon(FontAwesomeIcons.house),
      title: const Text("Trang chủ"),
      selectedColor: Colors.green,
    ),
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.heart),
      title: const Text("Yêu thích"),
      selectedColor: Colors.green,
    ),
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.cartShopping),
      title: const Text("Giỏ hàng"),
      selectedColor: Colors.green,
    ),
    SalomonBottomBarItem(
      icon: const Icon(FontAwesomeIcons.user),
      title: const Text("Tôi"),
      selectedColor: Colors.green,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _appBars = [
      AppBar(
        // backgroundColor: Colors.green,
        title: const ShipLocationWidget(),
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
      AppBar(),
      AppBar(),
      AppBar(
        backgroundColor: Colors.green,
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
                child: Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) => GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/search'),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5,
                              color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 50,
                                  child: Icon(FontAwesomeIcons.magnifyingGlass)
                              ),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tìm tên sản phẩm ...',
                                      hintStyle: TextStyle(
                                          fontSize: titleSize
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ) ,
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
