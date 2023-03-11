import 'package:get/get.dart';
import 'package:shop_getx_category_api/controllers/categories/categories_repository.dart';
import 'package:shop_getx_category_api/controllers/products/product_controller.dart';

//Todo: ProductsController
ProductController productController = ProductController();

//Todo: CategoriesController
class CategoriesController extends GetxController {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  var categories = [].obs;
  var currentIndex = 0.obs;
  var loading = false.obs;

  //Todo: CategoriesController
  CategoriesController() {
    loadCategories();
  }

  //Todo: LoadingCategories: Tai Danh Muc
  loadCategories() async {
    loading(true);
    var tcategories = await categoriesRepository.loadCategoriesFromApi();
    categories(tcategories);
    if (categories.isNotEmpty) {
      await productController
          .loadProductsFromRepo(categories[currentIndex.value]);
    }
    loading(false);
  }

  //Todo: ChangeCategories
  changeCategories(index) async {
    currentIndex(index);
    await productController.loadProductsFromRepo(categories[index]);
  }
}
