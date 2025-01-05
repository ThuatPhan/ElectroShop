import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/search_product.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchProductState {}

class SearchingProduct extends SearchProductState {}

class SearchProductSuccess extends SearchProductState {
  final List<ProductEntity> products;

  SearchProductSuccess({required this.products});
}

class SearchProductFailed extends SearchProductState {
  final String message;

  SearchProductFailed({required this.message});
}

class SearchProductCubit extends Cubit<SearchProductState> {
  final SearchProduct useCase;

  SearchProductCubit({required this.useCase}) : super(SearchingProduct());

  Future<void> searchProducts(String keyword) async {
    try {
      emit(SearchingProduct());
      final products = await useCase.call(SearchProductParams(keyword: keyword));
      emit(SearchProductSuccess(products: products));
    } catch (e) {
      emit(SearchProductFailed(message: e.toString()));
    }
  }
}
