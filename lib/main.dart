import 'package:flutter/material.dart';
import 'package:supabase_aula/pages/login.dart';
import 'package:supabase_aula/rotas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp()); // Inicialize o aplicativo com a HomePage
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(), // Defina a HomePage como a tela inicial
      routes: Rotas.define(),
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Rota não encontrada!'),
            ),
          ),
        );
      },
    );
  }
}
