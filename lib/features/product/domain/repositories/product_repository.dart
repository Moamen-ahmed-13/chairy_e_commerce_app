// import 'package:dartz/dartz.dart';

// import '../../../../core/errors/failures.dart';
// import '../entities/product.dart';

// abstract class ProductRepository {
//   Future<Either<Failure, List<Product>>> getProducts();
// }
import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:dio/dio.dart';

import '../../data/datasource/product_remote_data_source.dart';

class ProductRepository {
  final Dio dio = Dio();

  late ProductRemoteDataSource productRemoteDataSource;

  Future<List<ProductEntity>> fetchProducts() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<ProductEntity> products = (response.data['data'] as List<dynamic>)
            .map((json) => ProductEntity.fromJson(json))
            .toList();
        return products;
      } else {
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<ProductEntity>> searchProducts(String query) async {
    return await productRemoteDataSource.searchProducts(query);
  }
}
