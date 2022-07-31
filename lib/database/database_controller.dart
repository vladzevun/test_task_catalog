import 'package:test_task_catalog/database/database.dart';
import 'package:test_task_catalog/model/product.dart';

class DatabaseController{
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> createProduct(Product product) async {
    final db = await dbClient.db;

    var result = db.insert("productTable", product.toJSON());

    return result;
  }

  Future<List<Product>> getAllProducts({List<String>? columns}) async {
    final db = await dbClient.db;

    var result = await db.query("productTable",columns: columns);

    List<Product> products = result.isNotEmpty ? result.map((item) => Product.fromJSON(item)).toList() : [];

    return products;
  }

  Future<int> updateProduct(Product product) async {
    final db = await dbClient.db;

    var result = await db.update("productTable", product.toJSON(),where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<int> deleteProduct(int id) async {
    final db = await dbClient.db;

    var result = await db.delete("productTable", where: 'id = ?', whereArgs: [id]);

    return result;
  }
}