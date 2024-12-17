import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/main.dart';
import '/models/shop_item.dart';
import '/pages/catalog.dart';
import 'package:http/http.dart' as http;

class EditItem extends StatefulWidget {
  const EditItem({super.key, required this.catalogState, required this.itemID});
  final CatalogState catalogState;
  final int itemID;
  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController imageURLController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  Future<ShopItem> loadService() async {
    final createdResponse = await http.get(Uri(
        scheme: "http",
        host: appData.serverHost,
        port: appData.serverPort,
        path: "/service",
        queryParameters: {"id": widget.itemID.toString()}));

    final jsonResponse = jsonDecode(createdResponse.body);
    final ShopItem itemCurrentValue = ShopItem.fromJson(jsonResponse);
    return itemCurrentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Изменить стрижку"),
      ),
      body: FutureBuilder<ShopItem>(
        future: loadService(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            ShopItem loadedItem = snapshot.data!;
            titleController.text = loadedItem.Name;
            descriptionController.text = loadedItem.Description;
            imageURLController.text = loadedItem.ImageHref;
            priceController.text = loadedItem.PriceRubles.toString();
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Название",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Описание",
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: imageURLController,
                      decoration: const InputDecoration(
                        labelText: "URL картинки",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: "Цена",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 25, 64),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 10.0,
                              right: 20.0,
                              bottom: 10.0)),
                      child: const Text("Обновить",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      onPressed: () async {
                        if (titleController.text.isEmpty ||
                            priceController.text.isEmpty ||
                            imageURLController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          Navigator.pop(context);
                          return;
                        }
                        try {
                          ShopItem newItem = ShopItem(
                              loadedItem.ID,
                              titleController.text,
                              loadedItem.Category,
                              int.parse(priceController.text),
                              imageURLController.text,
                              descriptionController.text);
                          final createdResponse = await http.put(
                              Uri(
                                  scheme: "http",
                                  host: appData.serverHost,
                                  port: appData.serverPort,
                                  path: "/service"),
                              body: jsonEncode(newItem.toJson()));
                          jsonDecode(createdResponse.body);
                          setState(() {
                            appData.shopItems[appData
                                .indexOfShopItem(widget.itemID)] = newItem;
                          });
                        } catch (err) {}

                        if (mounted)
                        {
                           Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ));
          }
        },
      ),
    );
  }
}
