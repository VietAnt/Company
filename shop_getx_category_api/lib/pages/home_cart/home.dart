// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx_category_api/pages/home_cart/cart.dart';

import '../../controllers/categories/categories_controller.dart';
import '../../main.dart';
import '../splash/splash.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoriesController categoriesController = CategoriesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.grey[100],
        body: Obx(() {
          if (categoriesController.loading.value)
            return Center(child: CircularProgressIndicator());
          if (categoriesController.categories.isEmpty) {
            return Center(child: Text("No categories found"));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTop(),
                _buildCategoriesRow(),
                Expanded(
                  child: Obx(
                    () {
                      if (productController.loading.value)
                        return Center(child: CircularProgressIndicator());
                      if (productController.products.isEmpty) {
                        return Center(child: Text("No products found"));
                      }
                      if (productController.showGrid.value)
                        return GridView.builder(
                          padding: EdgeInsets.only(top: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: productController.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 0.0,
                              child: Container(
                                height: 150,
                                padding: EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(productController
                                              .products[index]["image"]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productController.products[index]
                                                  ["title"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Expanded(
                                              child: Text(
                                                productController
                                                        .products[index]
                                                    ["description"],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              "\$${productController.products[index]["price"]}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      return _buildProductsList();
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }

  ListView _buildProductsList() {
    return ListView.builder(
      itemCount: productController.products.length,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index) => Card(
        elevation: 0.0,
        child: Container(
          height: 120,
          padding: EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        productController.products[index]["image"]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productController.products[index]["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          productController.products[index]["description"],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "\$${productController.products[index]["price"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTop() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Cloths",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_down),
                )
              ],
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              productController.toggleGrid();
            },
            icon: Icon(Icons.filter_list)),
      ],
    );
  }

  Container _buildCategoriesRow() {
    return Container(
      height: 35.0,
      margin: EdgeInsets.only(top: 16),
      child: ListView.builder(
          itemCount: categoriesController.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Obx(
                () => InkWell(
                  onTap: () {
                    categoriesController.changeCategories(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: index == categoriesController.currentIndex.value
                          ? Colors.black87
                          : Colors.transparent,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      categoriesController.categories[index],
                      style: TextStyle(
                        color: index == categoriesController.currentIndex.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      leading: BackButton(),
      elevation: 0,
      title: const Text(
        "NShop",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              authController.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => SplashScreen()),
              );
            },
            icon: Icon(Icons.logout_outlined)),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartPage(),
              ));
            },
            icon: Icon(Icons.shopping_cart_outlined)),
      ],
    );
  }
}
