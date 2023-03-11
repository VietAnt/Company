import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shop_getx_category_api/controllers/cart/cart_repository.dart';

//Todo: CartController:
class CartController extends GetxController {
  CartRepository cartRepository = CartRepository();
  var cartItems = [];
  var loading = false.obs; //Tải
  var subtotal = 0.0.obs; //Tổng Giá

  //*-->CartController
  CartController() {
    loadCartFromApi();
  }

  //*->loadCartFromApi: Tải Giỏ Hàng Từ API
  loadCartFromApi() async {
    loading(true);
    var productList = await cartRepository.loadCartFromApi();

    for (var i = 0; i < productList.length; i++) {
      var product =
          await cartRepository.getProductFromApi(productList[i]["productId"]);

      //-->subtotal + cartItems
      subtotal(subtotal.value + product["price"] * productList[i]["quantity"]);
      cartItems
          .add({"product": product, "quantity": productList[i]["quantity"]});
    }
    loading(false);
  }
}
