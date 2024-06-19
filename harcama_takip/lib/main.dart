import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harcama_takip/auth/auth_gate.dart';
import 'package:harcama_takip/tools/locator.dart';
import 'package:harcama_takip/view/home_page.dart';
import 'package:harcama_takip/viewModel/auth_view_model.dart';
import 'package:harcama_takip/viewModel/home_page_view_model.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>AuthViewModel()),
            ChangeNotifierProvider(create: (context)=>HomePageViewModel()),
      ],
        child: AuthGate(),
      ),
    );
  }
}
