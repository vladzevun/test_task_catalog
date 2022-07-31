import 'package:flutter/material.dart';
import 'package:test_task_catalog/page/product_page.dart';

import '../blocs/product_bloc.dart';
import '../model/product.dart';
import 'add_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productBloc.getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productBloc.allProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var product = snapshot.data![index];
                return Container(
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          Text(
                            'Название товара: ${product.name}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Цена: ${product.price}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            (product.description == null || product.description!.isEmpty
                                ? 'Описания нет'
                                : 'Описание: ${product.description}'),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(product: product)
                              ),
                            );
                          },
                          icon: Icon(Icons.edit)
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          }
          else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          else if (snapshot.data == null) {
            return const Center(
              child: Text(
                "Товаров нет в списке.",
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage()
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
