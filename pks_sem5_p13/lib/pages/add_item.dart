import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/main.dart';
import '/models/shop_item.dart';
import '/pages/catalog.dart';
import 'package:http/http.dart' as http;
class AddItem extends StatelessWidget {
  AddItem({super.key, required this.catalogState});
  final CatalogState catalogState;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить стрижку"),
      ),
      body: Padding(
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
                        left: 20.0, top: 10.0, right: 20.0, bottom: 10.0)),
                child: const Text("Сохранить",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                onPressed: () async {
                  if (titleController.text.isEmpty || priceController.text.isEmpty || imageURLController.text.isEmpty || descriptionController.text.isEmpty)
                  {
                    Navigator.pop(context);
                    return;
                  }
                  try{
                    ShopItem newItem = ShopItem(
                      0,
                      titleController.text,
                      "Стрижка и укладка",
                      int.parse(priceController.text),
                      imageURLController.text,
                      descriptionController.text);
                      final createdResponse = await http.post(Uri(scheme: "http", host: appData.serverHost, port: appData.serverPort, path: "/service"), body: jsonEncode(newItem.toJson()));
                      Map<String, dynamic> jsonResponse = jsonDecode(createdResponse.body);
                      newItem.ID = jsonResponse["ID"] as int; 
                      catalogState.addItem(newItem);
                  }
                  catch (err)
                  {
                    rethrow;
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}
