import 'package:flutter/material.dart';

import '../models/product.dart';

class CartPage extends StatelessWidget {

  final List<Product> cartProducts;

  const CartPage({

    super.key,

    required this.cartProducts,
  });

  @override
  Widget build(BuildContext context) {

    double totalPrice = 0;

    for (var product in cartProducts) {

      totalPrice += product.price;
    }

    return Scaffold(

      appBar: AppBar(

        title: const Text("Sepetim"),

        backgroundColor: Colors.purple,
      ),

      body: cartProducts.isEmpty

          ? const Center(

              child: Text(

                "Sepet boş 🛒",

                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )

          : Column(

              children: [

                Expanded(

                  child: ListView.builder(

                    padding:
                        const EdgeInsets.all(16),

                    itemCount:
                        cartProducts.length,

                    itemBuilder:
                        (context, index) {

                      final product =
                          cartProducts[index];

                      return Container(

                        margin:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),

                        padding:
                            const EdgeInsets.all(
                          16,
                        ),

                        decoration:
                            BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Row(
                          children: [

                            ClipRRect(

                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),

                              child:
                                  Image.network(

                                product.image,

                                width: 80,
                                height: 80,

                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(
                              width: 16,
                            ),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    product.name,

                                    style:
                                        const TextStyle(

                                      fontSize: 18,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  Text(

                                    "₺${product.price}",

                                    style:
                                        const TextStyle(

                                      fontSize: 16,

                                      color:
                                          Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(

                  padding:
                      const EdgeInsets.all(24),

                  decoration:
                      const BoxDecoration(

                    color: Colors.white,
                  ),

                  child: Row(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                    children: [

                      const Text(

                        "Toplam:",

                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      Text(

                        "₺${totalPrice.toStringAsFixed(2)}",

                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.purple,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}