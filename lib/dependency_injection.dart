import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/repositories/cart_repository_impl.dart';
import 'package:electro_shop/data/repositories/category_repository_impl.dart';
import 'package:electro_shop/data/repositories/product_repository_impl.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/api_source_impl.dart';
import 'package:electro_shop/data/sources/network/cart_api_source.dart';
import 'package:electro_shop/data/sources/network/cart_api_source_impl.dart';
import 'package:electro_shop/data/sources/network/category_api_source.dart';
import 'package:electro_shop/data/sources/network/category_api_source_impl.dart';
import 'package:electro_shop/data/sources/network/product_api_source.dart';
import 'package:electro_shop/data/sources/network/product_api_source_impl.dart';
import 'package:electro_shop/domain/repositories/cart_repository.dart';
import 'package:electro_shop/domain/repositories/category_repository.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';
import 'package:electro_shop/domain/use_case/add_cart_item.dart';
import 'package:electro_shop/domain/use_case/delete_cart_item.dart';
import 'package:electro_shop/domain/use_case/get_cart_items.dart';
import 'package:electro_shop/domain/use_case/get_categories.dart';
import 'package:electro_shop/domain/use_case/get_product.dart';
import 'package:electro_shop/domain/use_case/get_products.dart';
import 'package:electro_shop/domain/use_case/search_product.dart';
import 'package:electro_shop/domain/use_case/update_cart_item_quantity.dart';
import 'package:electro_shop/presentation/bloc/auth_cubit.dart';
import 'package:electro_shop/presentation/bloc/cart_cubit.dart';
import 'package:electro_shop/presentation/bloc/cart_item_cubit.dart';
import 'package:electro_shop/presentation/bloc/categories_cubit.dart';
import 'package:electro_shop/presentation/bloc/product_detail_cubit.dart';
import 'package:electro_shop/presentation/bloc/product_of_category_cubit.dart';
import 'package:electro_shop/presentation/bloc/products_cubit.dart';
import 'package:electro_shop/presentation/bloc/search_product_cubit.dart';
import 'package:get_it/get_it.dart';

import 'domain/use_case/get_product_of_category.dart';

class DependencyInjection {
  final getIt = GetIt.instance;

  DependencyInjection.config() {
    getIt.registerSingleton<AuthCubit>(AuthCubit()..initialAuthenticate());
    //Api sources
    getIt.registerFactory<ApiSource>(() => ApiSourceImpl(baseUrl: apiUrl));
    getIt.registerFactory<CategoryApiSource>(() => CategoryApiSourceImpl(apiSource: getIt<ApiSource>()));
    getIt.registerFactory<ProductApiSource>(() => ProductApiSourceImpl(apiSource: getIt<ApiSource>()));
    getIt.registerFactory<CartApiSource>(() => CartApiSourceImpl(apiSource:getIt<ApiSource>()));
    //Repositories
    getIt.registerFactory<CategoryRepository>(() => CategoryRepositoryImpl(categoryApiSource: getIt<CategoryApiSource>()));
    getIt.registerFactory<ProductRepository>(() => ProductRepositoryImpl(productApiSource: getIt<ProductApiSource>()));
    getIt.registerFactory<CartRepository>(() => CartRepositoryImpl(cartApiSource: getIt<CartApiSource>()));
    //Use cases
    getIt.registerFactory<GetCategories>(() => GetCategories(categoryRepository: getIt<CategoryRepository>()));
    getIt.registerFactory<GetProducts>(() => GetProducts(productRepository: getIt<ProductRepository>()));
    getIt.registerFactory<GetProduct>(() => GetProduct(productRepository: getIt<ProductRepository>()));
    getIt.registerFactory<GetProductOfCategory>(()=> GetProductOfCategory(productRepository: getIt<ProductRepository>()));
    getIt.registerFactory<SearchProduct>(() => SearchProduct(productApiSource: getIt<ProductApiSource>()));
    getIt.registerFactory<AddCartItem>(() => AddCartItem(cartRepository: getIt<CartRepository>()));
    getIt.registerFactory<GetCartItems>(() => GetCartItems(cartRepository: getIt<CartRepository>()));
    getIt.registerFactory<DeleteCartItem>(() => DeleteCartItem(cartRepository: getIt<CartRepository>()));
    getIt.registerFactory<UpdateCartItem>(() => UpdateCartItem(cartRepository: getIt<CartRepository>()));
    //Cubits
    getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(useCase: getIt<GetCategories>())..getCategories());
    getIt.registerSingleton<ProductsCubit>(ProductsCubit(useCase: getIt<GetProducts>())..getProducts(1, productPerPage));
    getIt.registerFactory<ProductDetailCubit>(() => ProductDetailCubit(useCase: getIt<GetProduct>()));
    getIt.registerFactory<ProductOfCategoryCubit>(()=> ProductOfCategoryCubit(useCase: getIt<GetProductOfCategory>()));
    getIt.registerFactory<SearchProductCubit>(() => SearchProductCubit(useCase: GetIt.instance<SearchProduct>()));
    getIt.registerSingleton<CartItemCubit>(CartItemCubit(useCase: getIt<GetCartItems>())..getCartItems());
    getIt.registerSingleton<CartCubit>(
      CartCubit(
        addCartItemUseCase: getIt<AddCartItem>(),
        updateCartItemUseCase: getIt<UpdateCartItem>(),
        deleteCartItemUseCase: getIt<DeleteCartItem>()
      )
    );
  }
}