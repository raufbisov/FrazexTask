import 'package:frazex_task/models/product.dart';
import 'package:frazex_task/resources/api_provider.dart';

class ApiRepository {
  final ApiProvider _provider = ApiProvider();

  Future<List<Product>> getProductList() {
    return _provider.fetchProductList();
  }
}

class NetworkError extends Error {}
