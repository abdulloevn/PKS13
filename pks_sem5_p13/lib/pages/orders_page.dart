import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/main.dart';

import '../models/order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Мои заказы"),
      ),
      body: appData.orders.isEmpty ? const Center(child: Text("Вы пока ничего не заказали."),) : Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: appData.orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: OrderPreview(order: appData.orders[index]));
            },
          )),
    );
  }
}

class OrderPreview extends StatelessWidget {
  OrderPreview({super.key, required this.order});
  Order order;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Заказ от ${order.CreatedAt.day}/${order.CreatedAt.month}/${order.CreatedAt.year}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 30,),
              Text(
                "${order.Total} ₽",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          DataTable(
            columnSpacing: MediaQuery.of(context).size.width / 8,
            columns: const [
            DataColumn(label: Text("Название")),
            DataColumn(label: Text("Цена")),
            DataColumn(label: Text("Количество")),
      
          ], rows: List<DataRow>.generate(
            order.OrderItems.length,
            (index){
              return DataRow(cells: [
                DataCell(Text(order.OrderItems[index].item.Name)),
                DataCell(Text("${order.OrderItems[index].item.PriceRubles} ₽")),
                DataCell(Text(order.OrderItems[index].Count.toString())),
      
              ]);
            }
          ))
        ],
      ),
    );
  }
}

