import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex_task/blocs/product/product_bloc.dart';
import 'package:frazex_task/models/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ProductBloc _productBloc = ProductBloc();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: deviceSize.width * .25),
          child: TextField(
            onChanged: (text) {
              setState(() {
                _productBloc.add(GetProductListByName(text, context));
              });
            },
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchHint,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        BlocProvider.value(
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
        ),
      ],
    );
  }

  Center _buildError(ProductError state) {
    return Center(
      child: Text('${state.error}'),
    );
  }

  Expanded _buildProductListView(ProductLoaded state) {
    return Expanded(
      child: SizedBox(
        height: 1,
        child: ListView.builder(
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
        ),
      ),
    );
  }

  Container _buildLoading() {
    return Container();
  }
}
