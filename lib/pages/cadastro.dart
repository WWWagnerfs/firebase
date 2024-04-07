import 'package:flutter/material.dart';
import 'package:supabase_aula/compenents/customTextFormField.dart';
import 'package:supabase_aula/rotas.dart';
import '../database/OperationsFireBase.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController controller_nome = TextEditingController();
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_cpf = TextEditingController();
  final TextEditingController controller_dtn = TextEditingController();
  final TextEditingController controller_telefone = TextEditingController();

  @override
  void dispose() {
    controller_nome.dispose();
    controller_email.dispose();
    controller_cpf.dispose();
    controller_dtn.dispose();
    controller_telefone.dispose();
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
          'Cadastrar Nova Pessoa',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Rotas.homePage);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            CustomTextFormField(campo: 'Nome Completo', controlador: controller_nome),
            SizedBox(height: 10),
            CustomTextFormField(campo: 'E-Mail', controlador: controller_telefone),
            SizedBox(height: 10),
            CustomTextFormField(campo: 'CPF', controlador: controller_cpf),
            SizedBox(height: 10),
            CustomTextFormField(campo: 'Data de Nascimento', controlador: controller_dtn),
            SizedBox(height: 10),
            CustomTextFormField(campo: 'Telefone', controlador: controller_email),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  OperationsFirebaseDB().cadastrarPessoa(controller_nome.text, controller_telefone.text, controller_cpf.text, controller_dtn.text, controller_email.text);
                  controller_nome.clear();
                  controller_email.clear();
                  controller_cpf.clear();
                  controller_dtn.clear();
                  controller_telefone.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastro realizado com sucesso!')));
                  Navigator.pushReplacementNamed(context, Rotas.homePage);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue.shade600),
                ),
                child: Text('Cadastrar', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
