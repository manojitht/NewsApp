import 'package:newsapp/models/categories.dart';

class Utils {
  static List<CategoryModel> getCategories() {
    return [
      CategoryModel("General"),
      CategoryModel("Business"),
      CategoryModel("Technology"),
      CategoryModel("Science"),
      CategoryModel("Entertainment"),
      CategoryModel("Sports"),
      CategoryModel("Health"),
    ];
  }
}