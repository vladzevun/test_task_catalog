import 'dart:ffi';

import 'package:flutter/material.dart';

import '../blocs/product_bloc.dart';
import '../model/product.dart';

class ProductPage extends StatelessWidget {
  ProductPage({
    required this.product,
    Key? key
  }) : super(key: key);

  final Product product;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: product.name,
                  decoration: InputDecoration(
                    labelText: "Название продукта"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Название не может быть пустым';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    product.name = value;
                  },
                ),
                TextFormField(
                  initialValue: product.price.toString(),
                  decoration: InputDecoration(
                      labelText: "Цена продукта"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Цена не может быть пустой';
                    }
                    var t = double.tryParse(value);
                    if (t == null || t < 0.0) {
                      return 'Цена должна быть числом больше 0';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    product.price = double.tryParse(value);
                  },
                ),
                TextFormField(
                  initialValue: product.description,
                  decoration: InputDecoration(
                      labelText: "Описание продукта"
                  ),
                  onChanged: (value) {
                    product.description = value;
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        productBloc.updateProduct(product);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Сохранить')
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Отмена')
                ),
                TextButton(
                    onPressed: () {
                      productBloc.deleteProduct(product.id!);
                      Navigator.pop(context);
                    },
                    child: Text('Удалить товар',
                    style: TextStyle(
                      color: Colors.red
                    ),)
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
