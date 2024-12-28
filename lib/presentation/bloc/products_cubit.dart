import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/get_products.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductsState {}

class LoadingProducts extends ProductsState {
  List<ProductEntity>? prevProducts;
  LoadingProducts({this.prevProducts});
}

class ProductsLoadSuccess extends ProductsState {
  final bool hasMore;
  final List<ProductEntity> products;

  ProductsLoadSuccess({required this.products, required this.hasMore});
}

class ProductsLoadFailed extends ProductsState {
  final String message;

  ProductsLoadFailed({required this.message});
}

class ProductsCubit extends Cubit<ProductsState> {
  final GetProducts useCase;

  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;

  final List<ProductEntity> _products = [];

  ProductsCubit({required this.useCase}) : super(LoadingProducts());

  Future<void> getProducts(int pageNumber, int pageSize, {bool isRefresh = false}) async {
    if (_isFetching || !_hasMore) {
      return;
    }
    try {
      if(isRefresh) {
        _products.clear();
        _currentPage = 1;
      }
      _isFetching = true;
      emit(LoadingProducts(prevProducts: !isRefresh ? _products : null ));
      PagedModel pagedProducts = await useCase.call(
        GetProductsParams(pageNumber: pageNumber, pageSize: pageSize)
      );
      bool hasMoreProducts = pagedProducts.remainingItems > 0;
      List<ProductEntity> newProducts = pagedProducts.items as List<ProductEntity>;
      _products.addAll(newProducts);
      _hasMore = hasMoreProducts;
      _currentPage++;
      emit(
        ProductsLoadSuccess(
          products: _products,
          hasMore: hasMoreProducts,
        ),
      );
    } catch (e) {
      emit(ProductsLoadFailed(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore() async {
    if (_hasMore) {
      getProducts(_currentPage, productPerPage);
    }
  }
}
