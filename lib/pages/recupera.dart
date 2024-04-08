import 'package:flutter/material.dart';
import 'package:supabase_aula/compenents/customTextFormField.dart';
import 'package:supabase_aula/rotas.dart';

import '../database/OperationsFireBase.dart';

class RecuperaLogin extends StatefulWidget {
  const RecuperaLogin({Key? key});

  @override
  State<RecuperaLogin> createState() => _RecuperaLoginState();
}

class _RecuperaLoginState extends State<RecuperaLogin> {
  final TextEditingController controller_email = TextEditingController();


  @override
  void dispose() {
    controller_email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'Recuperar Conta',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Rotas.loginConta);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            CustomTextFormField(
              campo: 'E-Mail',
              controlador: controller_email,
              prefixIcon: Icons.email,
            ),

            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  OperationsFirebaseDB().recuperarConta(controller_email.text);
                  controller_email.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verifique sua caixa de email!')));
                  Navigator.pushReplacementNamed(context, Rotas.loginConta);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.purple),
                ),
                child: Text('Recuperar', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
        bottomSheet: Container(
          height: 10,
          color: Colors.purple,
        )
    );
  }
}
