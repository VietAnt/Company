import 'dart:convert';

import 'package:http/http.dart' as http;

//Todo: ProductRepository: Kho lưu trữ sản phẩm
class ProductsRepository {
  var url = "https://fakestoreapi.com/products/category/";

  //*function loadProductFromApi
  loadProductsFromApi(String categoryName) async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
}
