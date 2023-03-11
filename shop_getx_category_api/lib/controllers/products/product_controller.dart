import 'package:get/get.dart';
import 'package:shop_getx_category_api/controllers/products/products_repository.dart';

//Todo: ProductController:
class ProductController extends GetxController {
  ProductsRepository productsRepository = ProductsRepository();
  List products = [].obs;
  var showGrid = false.obs;
  var loading = false.obs;

  //*-->LoadProductFromRepo: Tải sản phẩm từ Kho với Danh Mục
  loadProductsFromRepo(String categoryName) async {
    loading(true);
    products = await productsRepository.loadProductsFromApi(categoryName);
    loading(false);
  }

  //*->toggleGrid: Chuyển đổi lưới
  toggleGrid() {
    showGrid(!showGrid.value);
  }
}
