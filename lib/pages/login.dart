import 'package:flutter/material.dart';
import 'package:supabase_aula/compenents/customTextFormField.dart';
import 'package:supabase_aula/rotas.dart';
import '../database/OperationsFireBase.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_senha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OperationsFirebaseDB _firebaseDB = OperationsFirebaseDB();

  @override
  void dispose() {
    controller_email.dispose();
    controller_senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        title: Text(
          'Faça seu Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
              //prefixIcon: Icons.email,
            ),

            SizedBox(height: 20),
            CustomTextFormField(
              campo: 'Senha',
              controlador: controller_senha,
              //isPassword: true,
              //prefixIcon: Icons.lock,
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // Verifica se os campos de email e senha estão vazios
                  if (controller_email.text.isEmpty ||
                      controller_senha.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Por favor, preencha todos os campos!')));
                    return; // Sai da função onPressed se os campos estiverem vazios
                  }

                  try {
                    // Chama a função para logar o usuário
                    final loginResult = await OperationsFirebaseDB()
                        .logarUsuario(
                            controller_email.text, controller_senha.text);

                    if (loginResult) {
                      // Se o login for bem-sucedido, limpa os campos e mostra a mensagem
                      controller_email.clear();
                      controller_senha.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login bem-sucedido!')));

                      // Navega para a homepage apenas se o login for bem-sucedido
                      Navigator.pushReplacementNamed(context, Rotas.homePage);
                    } else {
                      // Se o login falhar, limpa os campos, mostra a mensagem de erro e redireciona para a página de login
                      controller_email.clear();
                      controller_senha.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Email ou senha incorretos!')));
                      Navigator.pushReplacementNamed(context, Rotas.loginConta);
                    }
                  } catch (e) {
                    // Se ocorrer uma exceção durante o login, mostra a mensagem de erro e limpa os campos
                    controller_email.clear();
                    controller_senha.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email ou senha incorretos!')));
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade600),
                ),
                child: Text('Entrar', style: TextStyle(color: Colors.white)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Rotas.registroConta);
              },
              child: Text('Criar uma nova conta'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Cor do texto
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Rotas.recuperaConta);
              },
              child: Text('Esqueci minha senha'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Cor do texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
