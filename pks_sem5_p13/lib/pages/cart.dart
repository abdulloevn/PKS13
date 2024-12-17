import 'package:flutter/material.dart';
import '/main.dart';
import '/models/cart_item.dart';
import '/pages/item_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  createState() => CartState();
}

class CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    appData.cartState = this;
    
  }

  List<CartItem> cartItems = appData.cartItems;
  void forceUpdateState() {
    if (mounted) {
      setState(() {});
    }
  }
  int calcTotalAmount()
  {
    int total = 0;
    for (final cartItem_ in cartItems)
    {
      total += cartItem_.item.PriceRubles * cartItem_.Count;
    }
    return total;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Запись"),
        ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60, top: 15),
            child: cartItems.isEmpty
                ? const Center(child: Text("Вы пока ничего не добавили в Корзину."))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    itemCount: cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                        key: Key(index.toString()),
                        endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            extentRatio: 0.3,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Удалить запись'),
                                        content: Text(
                                            'Вы действительно хотите удалить "${cartItems[index].item.Name}"?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Отмена'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); 
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Удалить'),
                                            onPressed: () async {
                                              http.delete(Uri(scheme: "http", host: appData.serverHost, port: appData.serverPort, path: "/cart", queryParameters: {"service_id": cartItems[index].item.ID.toString()}));
                                              setState(() {
                                                cartItems.removeAt(
                                                    index); 
                                              });
                                              Navigator.of(context)
                                                  .pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                backgroundColor: Theme.of(context).canvasColor,
                                foregroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Удалить',
                              )
                            ]),
                        child: GestureDetector(
                          child: CartItemPreview(cartItem: cartItems[index]),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ItemView(shopItem: cartItems[index].item)));
                          },
                        ),
                      );
                    },
                  ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(right: 40, left: 20, bottom: 5),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () async {
                  if (cartItems.isEmpty) return;
                  await http.post(Uri(scheme: "http", host: appData.serverHost, port: appData.serverPort, path: "/order", queryParameters: {"user_id": "1"}));
                  await appData.fetchAllData();
                  cartItems = appData.cartItems;
                  appData.cartState!.forceUpdateState();
                  }, style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple), child: const Text("Оплатить", style: TextStyle(fontSize: 18, color: Colors.white)),),
                  Row(
                    children: [
                      const Text("Итог: ", style: TextStyle(fontSize: 18)),
                      Text("${calcTotalAmount()} ₽", style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.lightBlueAccent),),
                    ],
                  ),
                ],
              ),
            ),
          )
        )
        ],
      ),
    );
  }
}

class CartItemPreview extends StatefulWidget {
  CartItemPreview({super.key, required this.cartItem});
  CartItem cartItem;
  @override
  State<CartItemPreview> createState() => CartItemPreviewState();
}

class CartItemPreviewState extends State<CartItemPreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(widget.cartItem.item.ImageHref,
                      width: MediaQuery.of(context).size.width * 0.45,
                      fit: BoxFit.cover)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${(widget.cartItem.item.PriceRubles * 1.5 / 100).round() * 100}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 18,
                                  decorationThickness: 2),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${widget.cartItem.item.PriceRubles.toString()} ₽",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        Text(widget.cartItem.item.Name,
                            style: const TextStyle(fontSize: 16)),
                        Text(
                            widget.cartItem.item.Category,
                            style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (widget.cartItem.Count > 1) {
                              setState(() {
                                widget.cartItem.Count -= 1;
                              });
                              http.put(Uri(scheme: "http", host: appData.serverHost, port: appData.serverPort, path: "/cart", queryParameters: {"service_id": widget.cartItem.item.ID.toString(), "count": widget.cartItem.Count.toString()}));
                              appData.cartState!.forceUpdateState();
                            }
                          },
                          icon: const Icon(Icons.remove),
                          iconSize: 30,
                        ),
                        Text(
                          "${widget.cartItem.Count}",
                          style: const TextStyle(fontSize: 24),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              widget.cartItem.Count += 1;
                            });
                            http.put(Uri(scheme: "http", host: appData.serverHost, port: appData.serverPort, path: "/cart", queryParameters: {"service_id": widget.cartItem.item.ID.toString(), "count": widget.cartItem.Count.toString()}));
                            appData.cartState!.forceUpdateState();
                          },
                          icon: const Icon(Icons.add),
                          iconSize: 30,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
