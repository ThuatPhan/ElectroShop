import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/search_product.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchProductState {}

class SearchingProduct extends SearchProductState {
  final List<ProductEntity>? prevProducts;
  SearchingProduct({this.prevProducts});
}

class SearchProductSuccess extends SearchProductState {
  final bool hasMore;
  final List<ProductEntity> products;
  SearchProductSuccess({required this.hasMore, required this.products});
}

class SearchProductFailed extends SearchProductState {
  final String message;
  SearchProductFailed({required this.message});
}


class SearchProductCubit extends Cubit<SearchProductState> {
  final SearchProduct useCase;

  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  final List<ProductEntity> _products = [];


  SearchProductCubit({required this.useCase}) : super(SearchingProduct());


  Future<void> searchProducts(String keyword, int pageNumber, int pageSize, {bool isRefresh = false}) async {
    if (_isFetching || !_hasMore) {
      return;
    }
    try {
      if(isRefresh) {
        _products.clear();
        _currentPage = 1;
      }
      _isFetching = true;
      emit(SearchingProduct(prevProducts: !isRefresh ? _products : null ));
      PagedModel pagedProducts = await useCase.call(
          SearchProductParams(keyword: keyword, pageNumber: pageNumber, pageSize: pageSize)
      );
      bool hasMoreProducts = pagedProducts.remainingItems > 0;
      List<ProductEntity> newProducts = pagedProducts.items as List<ProductEntity>;
      _products.addAll(newProducts);
      _hasMore = hasMoreProducts;
      _currentPage++;
      emit(
        SearchProductSuccess(hasMore: _hasMore, products: _products)
      );
    } catch (e) {
      emit(SearchProductFailed(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore(String keyword) async {
    if (_hasMore) {
      searchProducts(keyword, _currentPage, productPerPage);
    }
  }
}