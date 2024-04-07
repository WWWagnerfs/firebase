import 'package:flutter/material.dart';
import '../database/OperationsFireBase.dart';
import '../rotas.dart';

class ListaFornecedorPage extends StatefulWidget {
  const ListaFornecedorPage({super.key});

  @override
  _ListaFornecedorPageState createState() => _ListaFornecedorPageState();
}

class _ListaFornecedorPageState extends State<ListaFornecedorPage> {
  late Future<List<String>> _fornecedorFuture;

  @override
  void initState() {
    super.initState();
    _fornecedorFuture = _getFornecedor();
  }

  Future<List<String>> _getFornecedor() async {
    return OperationsFirebaseDB().listarFornecedores();
  }

  Future<void> _showEditNameDialog(String nomeAtual, int index) async {
    TextEditingController _nomeController = TextEditingController(text: nomeAtual);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Fornecedor'),
        content: TextField(
          controller: _nomeController,
          decoration: InputDecoration(labelText: 'Nome do Fornecedor'),
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
              await OperationsFirebaseDB().atualizarFornecedor(nomeAtual, _nomeController.text as Map<String, dynamic>);
              setState(() {
                _fornecedorFuture = _getFornecedor();
              });
              Navigator.pop(context); // Fecha o Dialog
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> _excluirFornecedor(String nome) async {
    await OperationsFirebaseDB().excluirFornecedor(nome);
    setState(() {
      _fornecedorFuture = _getFornecedor();
    });
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
          'Listar Fornecedores',
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
        future: _fornecedorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum fornecedor cadastrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var fornecedor = snapshot.data![index];
                return Card(
                  color: Colors.blueAccent,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        _showEditNameDialog(fornecedor, index);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.tealAccent,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        _excluirFornecedor(fornecedor);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                    title: Text(
                      fornecedor,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
