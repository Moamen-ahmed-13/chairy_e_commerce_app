import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductEntity>> getProducts();
  Future<List<ProductEntity>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl(this.apiService);


  @override
  Future<List<ProductEntity>> getProducts() async {
     Response response = await apiService.getProducts();

  if (response.statusCode == 200 && response.data != null) {
    if (response.data['data'] is List) { 
      return (response.data['data'] as List)
          .map((e) => ProductEntity.fromJson(e))
          .toList();
    } else {
      throw Exception("Unexpected response format: ${response.data}");
    }
  } else {
    throw Exception("Failed to fetch products: ${response.statusMessage}");
  }
  }
  
  @override
  Future<List<ProductEntity>> searchProducts(String query) async{
    final response = await apiService.searchProducts(query);
    return response.map((product) => ProductEntity.fromJson(product)).toList();
  }
}
