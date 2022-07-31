import 'package:test_task_catalog/database/database_controller.dart';
import 'package:test_task_catalog/model/product.dart';

class Repository{
  final DatabaseController dbController = DatabaseController();

  Future getAllProducts() => dbController.getAllProducts();

  Future insertProduct(Product product) => dbController.createProduct(product);

  Future updateProduct(Product product) => dbController.updateProduct(product);

  Future deleteProduct(int index) => dbController.deleteProduct(index);
}