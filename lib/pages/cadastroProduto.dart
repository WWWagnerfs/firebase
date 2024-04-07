import 'package:flutter/material.dart';
import 'package:supabase_aula/compenents/customTextFormField.dart';
import 'package:supabase_aula/rotas.dart';
import '../database/OperationsFireBase.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({Key? key});

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final TextEditingController controller_nome = TextEditingController();
  final TextEditingController controller_descricao = TextEditingController();
  final TextEditingController controller_preco = TextEditingController();

  @override
  void dispose() {
    controller_nome.dispose();
    controller_descricao.dispose();
    controller_preco.dispose();
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
          'Cadastrar Novo Produto',
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
            CustomTextFormField(campo: 'Nome do Produto', controlador: controller_nome),
            SizedBox(height: 10),
            CustomTextFormField(campo: 'Descrição do Produto', controlador: controller_descricao),
            SizedBox(height: 10),
            CustomTextFormField(campo: 'Preço', controlador: controller_preco),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  OperationsFirebaseDB().cadastrarProduto(controller_nome.text, controller_descricao.text, controller_preco.text);
                  controller_nome.clear();
                  controller_descricao.clear();
                  controller_preco.clear();
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
