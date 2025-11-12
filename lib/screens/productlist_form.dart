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
    int _price = 0; // default
    String _description = "";
    String _category = "Footwear"; // default
    String _thumbnail = "";
    bool _isFeatured = false; // default

    final List<String> _categories = [
      'Footwear',
      'Clothing',
      'Accessories',
    ];

    bool isUrl(String input) {
    try {
      final uri = Uri.parse(input);
      return uri.isAbsolute;
    } catch (e) {
      return false; // Parsing failed, not a valid URI
    }
  }


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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                // === Nama Produk ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Nama Produk",
                      labelText: "Nama Produk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nama produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Price ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Harga Produk",
                      labelText: "Harga Produk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _price = int.parse(value);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harga produk tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Harga produk tidak valid";
                      }
                      if (int.parse(value) <= 0) {
                        return "Harga produk tidak boleh 0 ataupun kurang dari 0";
                      }
                      return null;
                    },
                  ),
                ),

                // === Description ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Deskripsi Produk",
                      labelText: "Deskripsi Produk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Deskripsi produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Category ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Kategori",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    initialValue: _category,
                    items: _categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(
                                  cat[0].toUpperCase() + cat.substring(1)),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue!;
                      });
                    },
                  ),
                ),

                // === Thumbnail URL ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      hintText: "URL Thumbnail (opsional)",
                      labelText: "URL Thumbnail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "URL Thumbnail tidak boleh kosong!";
                      }
                      if (!isUrl(value!) && value.isNotEmpty) {
                        return "URL Thumbnail bukan URL Valid";
                      }
                      return null;
                    },
                  ),
                ),

                // === Is Featured ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text("Tandai sebagai Produk Unggulan"),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),

                // === Tombol Simpan ===
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Produk berhasil tersimpan'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Judul: $_name'),
                                      Text('Harga: $_price'),
                                      Text('Deskripsi Produk: $_description'),
                                      Text('Kategori: $_category'),
                                      Text('Thumbnail: $_thumbnail'),
                                      Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _formKey.currentState!.reset();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],

              ),
            ),
          ),
        );
    }
}