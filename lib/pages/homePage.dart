import 'package:flutter/material.dart';
import 'package:supabase_aula/rotas.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text(
          'Página Inicial',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Rotas.loginConta);
                },
                child: Icon(Icons.logout, color: Colors.purple.shade200)),
          )
        ],
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(22),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 8,
          itemBuilder: (context, index) {
            List<IconData> icons = [
              Icons.person_add_alt_1,
              Icons.shopify_rounded,
              Icons.local_shipping,
              Icons.person_search_rounded,
              Icons.assignment,
              Icons.business,
              Icons.settings,
              Icons.window,
            ];
            List<String> titles = [
              'Cadastrar Pessoas',
              'Cadastro de Produtos',
              'Cadastrar Fornecedor',
              'Listar Pessoas',
              'Listar Produtos',
              'Listar Fornecedor',
              'Suporte',
              'Windows',
            ];
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.pushReplacementNamed(context, Rotas.cadastro);
                    break;
                  case 1:
                    Navigator.pushReplacementNamed(
                        context, Rotas.cadastroProduto);
                    break;
                  case 2:
                    Navigator.pushReplacementNamed(
                        context, Rotas.cadastroFornecedor);
                    break;
                  case 3:
                    Navigator.pushReplacementNamed(context, Rotas.listaPessoa);
                    break;
                  case 4:
                    Navigator.pushReplacementNamed(
                        context, Rotas.listaProdutos);
                    break;
                  case 5:
                    Navigator.pushReplacementNamed(
                        context, Rotas.listaFornecedor);
                    break;
                  case 6:
                    Navigator.pushReplacementNamed(context, Rotas.settings);
                    break;
                }
                print('Navegando para ${titles[index]}');
              },
              child: Card(
                color: Colors.purple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icons[index], size: 80, color: Colors.purple.shade50),
                    Text(titles[index], style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: Container(
        height: 10,
        color: Colors.purple,
      ),
    );
  }
}
