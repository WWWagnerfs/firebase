import 'package:flutter/material.dart';
import 'package:supabase_aula/compenents/customTextFormField.dart';
import 'package:supabase_aula/rotas.dart';
import '../database/OperationsFireBase.dart';

class CadastroFornecedor extends StatefulWidget {
  const CadastroFornecedor({Key? key});

  @override
  State<CadastroFornecedor> createState() => _CadastroFornecedorState();
}

class _CadastroFornecedorState extends State<CadastroFornecedor> {
  final TextEditingController controller_nome = TextEditingController();
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_cnpj = TextEditingController();
  final TextEditingController controller_rs = TextEditingController();
  final TextEditingController controller_telefone = TextEditingController();

  @override
  void dispose() {
    controller_nome.dispose();
    controller_email.dispose();
    controller_cnpj.dispose();
    controller_rs.dispose();
    controller_telefone.dispose();
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
          'Cadastrar Novo Fornecedor',
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
            CustomTextFormField(
              campo: 'Nome Completo',
              controlador: controller_nome,
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              campo: 'E-Mail',
              controlador: controller_email,
              prefixIcon: Icons.email,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              campo: 'CNPJ',
              controlador: controller_cnpj,
              prefixIcon: Icons.credit_card,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              campo: 'R/S',
              controlador: controller_cnpj,
              prefixIcon: Icons.work,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              campo: 'Telefone',
              controlador: controller_telefone,
              prefixIcon: Icons.phone,
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  OperationsFirebaseDB().cadastrarFornecedor(
                      controller_nome.text,
                      controller_email.text,
                      controller_cnpj.text,
                      controller_rs.text,
                      controller_telefone.text);
                  controller_nome.clear();
                  controller_email.clear();
                  controller_cnpj.clear();
                  controller_rs.clear();
                  controller_telefone.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Cadastro realizado com sucesso!')));
                  Navigator.pushReplacementNamed(context, Rotas.homePage);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.purple),
                ),
                child: Text('Cadastrar', style: TextStyle(color: Colors.white)),
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
