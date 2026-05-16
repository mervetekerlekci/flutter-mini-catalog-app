import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {

  Future<List<Product>> fetchProducts() async {

    final response = await http.get(

      Uri.parse(
        'https://dummyjson.com/products',
      ),
    );

    if (response.statusCode == 200) {

      final data =
          jsonDecode(response.body);

      final List productsJson =
          data['products'];

      return productsJson.map((item) {

        return Product(

          name: item['title'],

          price:
              item['price'].toDouble(),

          image:
              item['thumbnail'],

          isFavorite: false,
        );

      }).toList();

    } else {

      throw Exception(
        "Veri alınamadı",
      );
    }
  }
}