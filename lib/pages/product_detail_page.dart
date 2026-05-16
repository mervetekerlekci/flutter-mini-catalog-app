import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailPage
    extends StatelessWidget {

  final Product product;

  final Function(Product) addToCart;

  const ProductDetailPage({

    super.key,

    required this.product,

    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(product.name),

        backgroundColor: Colors.purple,
      ),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.center,

          children: [

            const SizedBox(height: 40),

            ClipRRect(

              borderRadius:
                  BorderRadius.circular(20),

              child: Image.network(

                product.image,

                height: 220,
                width: 220,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 40),

            Text(

              product.name,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(

              "₺${product.price}",

              style: const TextStyle(
                fontSize: 28,
                color: Colors.grey,
              ),
            ),

            const Spacer(),

            SizedBox(

              width: double.infinity,

              height: 60,

              child: ElevatedButton(

                onPressed: () {

                  addToCart(product);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                        "Ürün sepete eklendi 🛒",
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.purple,

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                ),

                child: const Text(

                  "Sepete Ekle",

                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}