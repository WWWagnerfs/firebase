import 'package:flutter/material.dart';
import '../database/OperationsFireBase.dart';
import '../rotas.dart';

class ListarProdutosPage extends StatefulWidget {
  const ListarProdutosPage({super.key});

  @override
  _ListarProdutosPageState createState() => _ListarProdutosPageState();
}

class _ListarProdutosPageState extends State<ListarProdutosPage> {
  late Future<List<String>> _produtosFuture;

  @override
  void initState() {
    super.initState();
    _produtosFuture = _getProdutos();
  }

  Future<List<String>> _getProdutos() async {
    return OperationsFirebaseDB().listarProdutos();
  }

  Future<void> _showEditNameDialog(String nomeAtual, int index) async {
    TextEditingController _nomeController =
        TextEditingController(text: nomeAtual);
    String novoNome = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Produto'),
        content: TextField(
          controller: _nomeController,
          onChanged: (value) {
            novoNome = value; // Atualize o novo nome conforme o usuário digita
          },
          decoration: InputDecoration(labelText: 'Nome do Produto'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o Dialog
            },
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _atualizarProduto(nomeAtual, novoNome);
              setState(() {
                _produtosFuture = _getProdutos();
              });
              Navigator.pop(context); // Fecha o Dialog
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> _atualizarProduto(String nomeAtual, String novoNome) async {
    await OperationsFirebaseDB()
        .atualizarProduto(nomeAtual, {'nome': novoNome});
  }

  Future<void> _excluirProduto(String nome) async {
    await OperationsFirebaseDB().excluirProduto(nome);
    setState(() {
      _produtosFuture = _getProdutos();
    });
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
          'Listar Produto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Rotas.homePage);
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _produtosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os produtos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum produto cadastrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var produto = snapshot.data![index];
                return Card(
                  color: Colors.purple.shade500,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        _showEditNameDialog(produto, index);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.tealAccent,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        _excluirProduto(produto);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.shopping_bag,
                            color: Colors.white), // Ícone "person"
                        SizedBox(width: 10), // Espaço entre o ícone e o texto
                        Text(
                          produto,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
        bottomSheet: Container(
          height: 10,
          color: Colors.purple,
        )
    );
  }
}
