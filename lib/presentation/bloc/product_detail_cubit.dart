import 'package:electro_shop/domain/entities/product_entity.dart';
import 'package:electro_shop/domain/use_case/get_product.dart';
import 'package:electro_shop/domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductDetailState{}

class LoadingProduct extends ProductDetailState{}

class ProductLoadSuccess extends ProductDetailState{
   final ProductEntity productEntity;
   ProductLoadSuccess({required this.productEntity});
}

class ProductLoadFailed extends ProductDetailState{
  String errorMessage;
  ProductLoadFailed({required this.errorMessage});
}

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProduct useCase;
  ProductDetailCubit({required this.useCase}):super(LoadingProduct());

  Future<void> getProduct(int productId) async{
    try{
      ProductEntity productEntity = await useCase.call(GetProductParams(id: productId));
      emit(ProductLoadSuccess(productEntity: productEntity));
    }catch(e){
      emit(ProductLoadFailed(errorMessage: e.toString()));
    }
  }
}
