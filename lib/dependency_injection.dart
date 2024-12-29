import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/repositories/category_repository_impl.dart';
import 'package:electro_shop/data/repositories/product_repository_impl.dart';
import 'package:electro_shop/data/sources/network/api_source.dart';
import 'package:electro_shop/data/sources/network/api_source_impl.dart';
import 'package:electro_shop/data/sources/network/category_api_source.dart';
import 'package:electro_shop/data/sources/network/category_api_source_impl.dart';
import 'package:electro_shop/data/sources/network/product_api_source.dart';
import 'package:electro_shop/data/sources/network/product_api_source_impl.dart';
import 'package:electro_shop/domain/repositories/category_repository.dart';
import 'package:electro_shop/domain/repositories/product_repository.dart';
import 'package:electro_shop/domain/use_case/get_categories.dart';
import 'package:electro_shop/domain/use_case/get_products.dart';
import 'package:electro_shop/presentation/bloc/auth_cubit.dart';
import 'package:electro_shop/presentation/bloc/categories_cubit.dart';
import 'package:electro_shop/presentation/bloc/products_cubit.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  final getIt = GetIt.instance;

  DependencyInjection.config() {
    getIt.registerSingleton<AuthCubit>(AuthCubit()..initialAuthenticate());
    getIt.registerSingleton<ApiSource>(ApiSourceImpl(baseUrl: apiUrl));
    getIt.registerSingleton<ProductApiSource>(ProductApiSourceImpl(apiSource: getIt<ApiSource>()));
    getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl(productApiSource: getIt<ProductApiSource>()));
    getIt.registerSingleton<GetProducts>(GetProducts(productRepository: getIt<ProductRepository>()));
    getIt.registerSingleton<CategoryApiSource>(CategoryApiSourceImpl(apiSource: getIt<ApiSource>()));
    getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(categoryApiSource: getIt<CategoryApiSource>()));
    getIt.registerSingleton<GetCategories>(GetCategories(categoryRepository: getIt<CategoryRepository>()));
    getIt.registerSingleton<CategoriesCubit>(CategoriesCubit(useCase: getIt<GetCategories>())..getCategories());
    getIt.registerSingleton<ProductsCubit>(ProductsCubit(useCase: getIt<GetProducts>())..getProducts(1, productPerPage));
  }
}