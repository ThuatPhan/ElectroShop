import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/get_product_of_category.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductOfCategoryState {}

class LoadingProductOfCategory extends ProductOfCategoryState {}

class ProductOfCategoryLoadSuccess extends ProductOfCategoryState {
  final List<ProductEntity> products;

  ProductOfCategoryLoadSuccess({required this.products});
}

class ProductOfCategoryLoadFailed extends ProductOfCategoryState {
  final String message;

  ProductOfCategoryLoadFailed({required this.message});
}

class ProductOfCategoryCubit extends Cubit<ProductOfCategoryState> {
  ProductOfCategoryCubit({required this.useCase}) : super(LoadingProductOfCategory());
  final GetProductOfCategory useCase;

  Future<void> getProductOfCategory(int categoryId) async {
    try {
      emit(LoadingProductOfCategory());
      final products = await useCase.call(
        GetProductOfCategoryParams(categoryId: categoryId),
      );
      emit(ProductOfCategoryLoadSuccess(products: products));
    } catch (e) {
      emit(ProductOfCategoryLoadFailed(message: e.toString()));
    }
  }
}
