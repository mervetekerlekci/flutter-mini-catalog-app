import 'package:flutter/material.dart';

import 'models/product.dart';
import 'services/api_service.dart';
import 'pages/product_detail_page.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Product> products = [];

  List<Product> filteredProducts = [];

  List<Product> cartProducts = [];

  bool showOnlyFavorites = false;

  final ApiService apiService =
      ApiService();

  @override
  void initState() {

    super.initState();

    loadProducts();
  }

  Future<void> loadProducts() async {

    final result =
        await apiService.fetchProducts();

    setState(() {

      products = result;

      filteredProducts = result;
    });
  }

  void searchProducts(String query) {

    final results = products.where((product) {

      final title =
          product.name.toLowerCase();

      final input =
          query.toLowerCase();

      return title.contains(input);

    }).toList();

    setState(() {

      filteredProducts = results;
    });
  }

  void toggleFavorite(Product product) {

    setState(() {

      product.isFavorite =
          !product.isFavorite;
    });
  }

  void addToCart(Product product) {

    setState(() {

      cartProducts.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {

    final displayedProducts =

        showOnlyFavorites

            ? filteredProducts.where((product) {

                return product.isFavorite;

              }).toList()

            : filteredProducts;

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: Builder(

        builder: (context) {

          return Scaffold(

            backgroundColor: Colors.grey[200],

            appBar: AppBar(

              title: const Text("Mini Katalog"),

              backgroundColor: Colors.purple,

              actions: [

                IconButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) {

                          return CartPage(

                            cartProducts:
                                cartProducts,
                          );
                        },
                      ),
                    );
                  },

                  icon: Stack(

                    children: [

                      const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),

                      Positioned(

                        right: 0,

                        child: Container(

                          padding:
                              const EdgeInsets.all(4),

                          decoration:
                              const BoxDecoration(

                            color: Colors.red,

                            shape: BoxShape.circle,
                          ),

                          child: Text(

                            cartProducts.length
                                .toString(),

                            style: const TextStyle(

                              color: Colors.white,

                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            body: products.isEmpty

                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )

                : Column(

                    children: [

                      Padding(

                        padding:
                            const EdgeInsets.all(16),

                        child: TextField(

                          onChanged:
                              searchProducts,

                          decoration:
                              InputDecoration(

                            hintText:
                                "Ürün ara...",

                            prefixIcon:
                                const Icon(
                              Icons.search,
                            ),

                            filled: true,

                            fillColor:
                                Colors.white,

                            border:
                                OutlineInputBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),

                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      Padding(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),

                        child: Row(

                          children: [

                            ElevatedButton(

                              onPressed: () {

                                setState(() {

                                  showOnlyFavorites =
                                      false;
                                });
                              },

                              child: const Text(
                                "Tümü",
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            ElevatedButton(

                              onPressed: () {

                                setState(() {

                                  showOnlyFavorites =
                                      true;
                                });
                              },

                              child: const Text(
                                "Favoriler",
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Expanded(

                        child: GridView.builder(

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          itemCount:
                              displayedProducts.length,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,

                            crossAxisSpacing: 16,

                            mainAxisSpacing: 16,

                            childAspectRatio: 0.75,
                          ),

                          itemBuilder:
                              (context, index) {

                            final product =
                                displayedProducts[index];

                            return GestureDetector(

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (context) {

                                      return ProductDetailPage(

                                        product:
                                            product,

                                        addToCart:
                                            addToCart,
                                      );
                                    },
                                  ),
                                );
                              },

                              child: Container(

                                padding:
                                    const EdgeInsets.all(
                                  16,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white,

                                  borderRadius:
                                      BorderRadius.circular(
                                    20,
                                  ),
                                ),

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Align(

                                      alignment:
                                          Alignment.topRight,

                                      child: IconButton(

                                        onPressed: () {

                                          toggleFavorite(
                                            product,
                                          );
                                        },

                                        icon: Icon(

                                          product.isFavorite

                                              ? Icons.favorite

                                              : Icons.favorite_border,

                                          color:
                                              Colors.red,
                                        ),
                                      ),
                                    ),

                                    Expanded(

                                      child: ClipRRect(

                                        borderRadius:
                                            BorderRadius.circular(
                                          16,
                                        ),

                                        child:
                                            Image.network(

                                          product.image,

                                          width:
                                              double.infinity,

                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 12,
                                    ),

                                    Text(

                                      product.name,

                                      maxLines: 2,

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      style:
                                          const TextStyle(

                                        fontSize: 18,

                                        fontWeight:
                                            FontWeight.bold,
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}