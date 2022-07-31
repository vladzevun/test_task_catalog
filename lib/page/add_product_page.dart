import 'package:flutter/material.dart';
import 'package:test_task_catalog/blocs/product_bloc.dart';
import 'package:test_task_catalog/model/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    Key? key,
  }) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? productName;

  final _formKey = GlobalKey<FormState>();

  final Product _product = Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление нового товара'),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
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
                      _product.name = value;
                    },
                  ),
                  TextFormField(
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
                      _product.price = double.tryParse(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Описание продукта"
                    ),
                    onChanged: (value) {
                      _product.description = value;
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          productBloc.addProduct(_product);
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
                ],
              )
          )
        ],
      ),
    );
  }
}
