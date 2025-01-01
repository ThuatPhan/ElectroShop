import 'package:electro_shop/constants.dart';
import 'package:electro_shop/data/models/paged_model.dart';
import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/get_product_of_category.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductOfCategoryState {}

class LoadingProductOfCategory extends ProductOfCategoryState {
  List<ProductEntity>? prevProducts;
  LoadingProductOfCategory({this.prevProducts});
}

class ProductOfCategoryLoadSuccess extends ProductOfCategoryState {
  final bool hasMore;
  final List<ProductEntity> products;

  ProductOfCategoryLoadSuccess({required this.products, required this.hasMore});
}

class ProductOfCategoryLoadFailed extends ProductOfCategoryState {
  final String message;

  ProductOfCategoryLoadFailed({required this.message});
}

class ProductOfCategoryCubit extends Cubit<ProductOfCategoryState> {
  final GetProductOfCategory useCase;

  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;

  final List<ProductEntity> _products = [];

  ProductOfCategoryCubit({required this.useCase}) : super(LoadingProductOfCategory());

  Future<void> getProductOfCategory(int categoryId, int pageNumber, int pageSize, {bool isRefresh = false}) async {
    if (_isFetching || !_hasMore) {
      return;
    }
    try {
      if (isRefresh) {
        _products.clear();
        _currentPage = 1;
      }
      _isFetching = true;
      emit(LoadingProductOfCategory(prevProducts: !isRefresh ? _products : null));
      PagedModel pagedProducts = await useCase.call(
        GetProductOfCategoryParams(categoryId: categoryId, pageNumber: pageNumber, pageSize: pageSize),
      );
      bool hasMoreProducts = pagedProducts.remainingItems > 0;
      List<ProductEntity> newProducts = pagedProducts.items as List<ProductEntity>;
      _products.addAll(newProducts);
      _hasMore = hasMoreProducts;
      _currentPage++;
      emit(ProductOfCategoryLoadSuccess(products: _products, hasMore: hasMoreProducts));
    } catch (e) {
      emit(ProductOfCategoryLoadFailed(message: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore(int categoryId) async {
    if (_hasMore && !_isFetching) {
      await getProductOfCategory(categoryId, _currentPage, productPerPage);
    }
  }
}
