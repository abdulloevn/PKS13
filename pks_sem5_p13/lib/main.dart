import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/components/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/pages/favourite.dart';
import 'models/global_data.dart';
import 'pages/cart.dart';
import 'pages/catalog.dart';

GlobalData appData = GlobalData();
void main() async {
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJidmxqbmpmdWNhdnFkYXBveGVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3NzE2OTcsImV4cCI6MjA0NzM0NzY5N30.g2SIKsKY2YDzwpU21rZcj4OEF1boQTTTQzKnuOzDAgg",
    url: "https://bbvljnjfucavqdapoxeq.supabase.co",
  );
  await appData.fetchAllData();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  List<Widget> pages = [const Catalog(), const Favourite(), const Cart(), const AuthGate()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: Scaffold(
        
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items:const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.cut), label: "Стрижки"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Избранные"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: "Запись"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          currentIndex: selectedIndex,
          useLegacyColorScheme: true,
          onTap: (int barItemIndex) => {
            setState(() {
              selectedIndex = barItemIndex;
            })
          },
          ),
      ),
    );
  }
}

