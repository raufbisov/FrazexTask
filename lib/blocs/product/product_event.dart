part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  final BuildContext context;
  const ProductEvent(this.context);

  @override
  List<Object> get props => [];
}

class GetProductList extends ProductEvent {
  const GetProductList(super.context);
}

class GetProductListByName extends ProductEvent {
  final String searchText;
  const GetProductListByName(this.searchText, super.context);
}
