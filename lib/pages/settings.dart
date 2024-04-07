  import 'package:flutter/material.dart';
  import 'package:supabase_aula/rotas.dart';
  import 'package:webview_flutter/webview_flutter.dart';

  class SettingsPage extends StatefulWidget {
    const SettingsPage({Key? key}) : super(key: key);

    @override
    State<SettingsPage> createState() => _SettingsPageState();
  }

  class _SettingsPageState extends State<SettingsPage> {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('https://firebase.google.com'));

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 15,
          centerTitle: true,
          backgroundColor: Colors.blue.shade600,
          title: const Text(
            'Suporte',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Rotas.homePage);
            },
          ),
        ),
        body: WebViewWidget(controller: controller),
      );
    }
  }
