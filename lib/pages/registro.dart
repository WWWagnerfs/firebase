import 'package:flutter/material.dart';
import 'package:supabase_aula/compenents/customTextFormField.dart';
import 'package:supabase_aula/rotas.dart';
import '../database/OperationsFireBase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroLogin extends StatefulWidget {
  const CadastroLogin({Key? key});

  @override
  State<CadastroLogin> createState() => _CadastroLoginState();
}

class _CadastroLoginState extends State<CadastroLogin> {
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_senha = TextEditingController();
  final TextEditingController controller_redigitaSenha = TextEditingController();

  @override
  void dispose() {
    controller_email.dispose();
    controller_senha.dispose();
    controller_redigitaSenha.dispose();
    super.dispose();
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      Navigator.pushReplacementNamed(context, Rotas.loginConta);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'Cadastro Usuário',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.popAndPushNamed(context, Rotas.loginConta);
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
            SizedBox(height: 10),
            CustomTextFormField(
              campo: 'Senha',
              controlador: controller_senha,
              isPassword: true,
              prefixIcon: Icons.lock,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              campo: 'Redigite a Senha',
              controlador: controller_redigitaSenha,
              isPassword: true,
              prefixIcon: Icons.lock,
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller_senha.text != controller_redigitaSenha.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('As senhas não coincidem!')),
                    );
                    return;
                  }
                  cadastrarUsuario(controller_email.text, controller_senha.text);
                  controller_email.clear();
                  controller_senha.clear();
                  controller_redigitaSenha.clear();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.purple),
                ),
                child: Text('Criar Conta', style: TextStyle(color: Colors.white)),
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
