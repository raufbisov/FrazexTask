// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:frazex_task/models/product.dart';
import 'package:frazex_task/resources/api_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final ApiRepository repository = ApiRepository();

    on<GetProductList>((event, emit) async {
      try {
        emit(ProductLoading());
        List<Product> productList = await repository.getProductList();
        emit(ProductLoaded(productList));
        if (productList[0].error != null) {
          emit(ProductError(productList[0].error));
        }
      } on NetworkError {
        emit(ProductError(AppLocalizations.of(event.context)!.productError));
      }
    });

    on<GetProductListByName>(
      (event, emit) async {
        try {
          emit(ProductLoading());
          List<Product> searchedProductList = <Product>[];
          if (event.searchText.isNotEmpty) {
            List<Product> productList = await repository.getProductList();
            if (productList[0].error != null) {
              emit(ProductError(productList[0].error));
            } else {
              searchedProductList.addAll(productList.where(
                  (element) => element.id.toString() == event.searchText));
              searchedProductList.addAll(productList
                  .where((element) => element.title!
                      .toLowerCase()
                      .contains(event.searchText.toLowerCase()))
                  .toList());
            }
          }
          emit(ProductLoaded(searchedProductList));
        } on NetworkError {
          emit(ProductError(AppLocalizations.of(event.context)!.productError));
        }
      },
    );
  }
}
