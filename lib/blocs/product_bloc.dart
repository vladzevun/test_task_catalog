import 'package:rxdart/rxdart.dart';
import 'package:test_task_catalog/model/product.dart';
import 'package:test_task_catalog/repository/repository.dart';

class ProductBloc{
  final Repository repository = Repository();

  final PublishSubject<List<Product>> _productFetcher = PublishSubject<List<Product>>();

  Stream<List<Product>> get allProducts => _productFetcher.stream;

  ProductBloc(){
    getAllProducts();
  }

  getAllProducts() async {
    List<Product> product = await repository.getAllProducts();
    _productFetcher.sink.add(product);
  }

  addProduct(Product product) async {
    await repository.insertProduct(product);
    getAllProducts();
  }

  updateProduct(Product product) async {
    repository.updateProduct(product);
    getAllProducts();
  }

  deleteProduct(int id) async {
    repository.deleteProduct(id);
    getAllProducts();
  }

  void dispose() {
    _productFetcher.close();
  }
}

final productBloc = ProductBloc();