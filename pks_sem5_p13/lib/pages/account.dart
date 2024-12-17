import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/models/auth_service.dart';
import 'package:pks_sem5_p8/pages/orders_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/main.dart';
import '/pages/account_update.dart';
class AccountPage extends StatefulWidget{
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    appData.accountPageState = this;

    final authService = AuthService();
    user = authService.getCurrentUser();
  }
  void forceUpdateState()
  {
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            const Icon(Icons.account_circle, size: 200.0),
            const SizedBox(height: 10,),
            Text(/*appData.account!.Name*/ user!.userMetadata!["display_name"] as String, style: const TextStyle(
              fontSize: 22
            ),),
            const SizedBox(height: 10,),
            Text(/*appData.account!.Email*/ user!.email!),
            const SizedBox(height: 10,),
            Text(appData.account!.PhoneNumber),
            const SizedBox(height: 20,),
            TextButton(onPressed: (){
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountUpdatePage()));
            }, child: const Text("Обновить данные", style: TextStyle(fontSize: 18),),),
             TextButton(onPressed: (){
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersPage()));
            }, child: const Text("Мои заказы", style: TextStyle(fontSize: 18),),),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox.expand(child: TextButton(onPressed: () async {
          final authService = AuthService();
          await authService.logout();
        }, child: const Text("Выйти", style: TextStyle(fontSize: 18),),))
      ],
    );
  }
}