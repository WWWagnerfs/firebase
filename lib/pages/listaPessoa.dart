import 'package:flutter/material.dart';
import '../database/OperationsFireBase.dart';
import '../rotas.dart';

class ListaPessoaPage extends StatefulWidget {
  const ListaPessoaPage({Key? key}) : super(key: key);

  @override
  _ListaPessoaPageState createState() => _ListaPessoaPageState();
}

class _ListaPessoaPageState extends State<ListaPessoaPage> {
  late Future<List<String>> _pessoasFuture;

  @override
  void initState() {
    super.initState();
    _pessoasFuture = _getPessoas();
  }

  Future<List<String>> _getPessoas() async {
    return OperationsFirebaseDB().listarPessoas();
  }

  Future<void> _excluirPessoa(String nome) async {
    await OperationsFirebaseDB().excluirPessoa(nome);
    setState(() {
      _pessoasFuture = _getPessoas();
    });
  }

  Future<void> _atualizarPessoa(String nomeAtual, String novoNome) async {
    await OperationsFirebaseDB()
        .atualizarPessoa(nomeAtual, {'nome': novoNome});
  }

  Future<void> _showEditNameDialog(String nomeAtual, int index) async {
    TextEditingController _nomeController =
        TextEditingController(text: nomeAtual);
    String novoNome = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Usuário'),
        content: TextField(
          controller: _nomeController,
          onChanged: (value) {
            novoNome = value; // Atualize o novo nome conforme o usuário digita
          },
          decoration: InputDecoration(labelText: 'Nome do Usuário'),
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
              await _atualizarPessoa(nomeAtual, novoNome);
              setState(() {
                _pessoasFuture = _getPessoas();
              });
              Navigator.pop(context); // Fecha o Dialog
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
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
          'Listar Pessoas',
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
        future: _pessoasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma pessoa cadastrada'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var pessoa = snapshot.data![index];
                return Card(
                  color: Colors.purple.shade500,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        _showEditNameDialog(pessoa,
                            index); // Implemente a edição da pessoa aqui
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.tealAccent,
                      ),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.person,
                            color: Colors.white), // Ícone "person"
                        SizedBox(width: 10), // Espaço entre o ícone e o texto
                        Text(
                          pessoa,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        _excluirPessoa(pessoa);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
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
