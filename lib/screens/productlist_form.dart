import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    String _description = "";
    String _category = "update"; // default
    String _thumbnail = "";
    bool _isFeatured = false; // default


    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Add Product Form',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),

          // TODO: Tambahkan drawer yang sudah dibuat di sini
          drawer: LeftDrawer(),

          body: Form(
            key: _formKey,
            child: SingleChildScrollView(),
          ),
        );
    }
}