import 'dart:convert';
import 'package:http/http.dart' as http;

//Todo: CartRepository: Kho lưu trữ Giỏ Hàng
class CartRepository {
  var url = "https://fakestoreapi.com/carts/1";
  var purl = "https://fakestoreapi.com/products/";

  //Todo: loadCartFromApi: Tải Giỏ Hàng Từ API
  loadCartFromApi() async {
    var response = await http.get(Uri.parse(url));
    var productsJson = json.decode(response.body);
    return productsJson['products'];
  }

  //Todo: getProductFromApi: Tải danh mục từ API
  Future getProductFromApi(productId) async {
    var response = await http.get(Uri.parse(purl + productId.toString()));
    return json.decode(response.body);
  }
}
