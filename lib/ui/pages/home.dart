import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex_task/blocs/product/product_bloc.dart';
import 'package:frazex_task/models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductBloc _productBloc = ProductBloc();

  @override
  void initState() {
    _productBloc.add(GetProductList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productBloc,
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
            ));
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial || state is ProductLoading) {
              return _buildLoading();
            } else if (state is ProductLoaded) {
              return _buildProductListView(state);
            } else if (state is ProductError) {
              return _buildError(state);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Center _buildError(ProductError state) {
    return Center(
      child: Text('${state.error}'),
    );
  }

  ListView _buildProductListView(ProductLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.product.length,
      itemBuilder: (context, index) {
        Product product = state.product[index];
        return ListTile(
          leading: Text('${product.price}\$'),
          title: Text('${product.title}'),
          subtitle: Text('${product.category}'),
          trailing: Text('id: ${product.id}'),
        );
      },
    );
  }

  Center _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
