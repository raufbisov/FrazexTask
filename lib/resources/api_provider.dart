import 'dart:convert';
import 'dart:developer';

import 'package:frazex_task/models/product.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<List<Product>> fetchProductList() async {
    List<Product> productList = <Product>[];
    try {
      var response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      for (var product in jsonDecode(response.body)) {
        productList.add(Product.fromJson(product));
      }
      return productList;
    } catch (e) {
      log(e.toString());
      return <Product>[Product.error('Error')];
    }
  }
}
