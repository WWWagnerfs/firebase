import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OperationsFirebaseDB {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> cadastrarPessoa(String nome, String email, String CPF,
      String dtn, String telefone) async {
    await _firestore
        .collection('pessoas')
        .add({
      'nome': nome,
      'email': email,
      'cpf': CPF,
      'dtn': dtn,
      'telefone': telefone,
    })
        .then((value) => print('Pessoa cadastrada com sucesso'))
        .catchError((error) => print('Erro ao cadastrar pessoa: $error'));
  }

  Future<void> cadastrarProduto(String nome, String descricao, String preco) async {
    await _firestore
        .collection('produtos')
        .add({'nome': nome, 'descricao': descricao, 'preco': preco})
        .then((value) => print('Produto cadastrado com sucesso'))
        .catchError((error) => print('Erro ao cadastrar produto: $error'));
  }

  Future<void> cadastrarFornecedor(String nome, String email, String CNPJ,
      String rs, String telefone) async {
    await _firestore
        .collection('fornecedores')
        .add({
      'nome': nome,
      'email': email,
      'cnpj': CNPJ,
      'rs': rs,
      'telefone': telefone,
    })
        .then((value) => print('Fornecedor cadastrado com sucesso'))
        .catchError((error) => print('Erro ao cadastrar fornecedor: $error'));
  }

  Future<void> excluirFornecedor(String nome) async {
    await _firestore
        .collection('fornecedores')
        .where('nome', isEqualTo: nome)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    }).catchError((error) => print('Erro ao excluir fornecedor: $error'));
  }

  Future<void> atualizarFornecedor(String nome, Map<String, dynamic> novosDados) async {
    await _firestore
        .collection('fornecedores')
        .where('nome', isEqualTo: nome)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.update(novosDados);
    }).catchError((error) => print('Erro ao atualizar fornecedor: $error'));
  }

  Future<List<String>> listarFornecedores() async {
    List<String> nomes = [];

    await _firestore.collection('fornecedores').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        nomes.add(doc['nome']);
      }
    }).catchError((error) => print('Erro ao listar fornecedores: $error'));

    return nomes;
  }

  Future<List<String>> listarPessoas() async {
    List<String> nomes = [];

    await _firestore.collection('pessoas').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        nomes.add(doc['nome']);
      }
    }).catchError((error) => print('Erro ao listar pessoas: $error'));

    return nomes;
  }

  Future<void> excluirPessoa(String nome) async {
    await _firestore
        .collection('pessoas')
        .where('nome', isEqualTo: nome)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    }).catchError((error) => print('Erro ao excluir pessoa: $error'));
  }

  Future<void> atualizarPessoa(String nome, Map<String, dynamic> novosDados) async {
    await _firestore
        .collection('pessoas')
        .where('nome', isEqualTo: nome)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.update(novosDados);
    }).catchError((error) => print('Erro ao atualizar pessoa: $error'));
  }

  Future<List<String>> listarProdutos() async {
    List<String> nomes = [];

    await _firestore.collection('produtos').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        nomes.add(doc['nome']);
      }
    }).catchError((error) => print('Erro ao listar produtos: $error'));

    return nomes;
  }

  Future<void> excluirProduto(String nome) async {
    await _firestore
        .collection('produtos')
        .where('nome', isEqualTo: nome)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    }).catchError((error) => print('Erro ao excluir produto: $error'));
  }

  Future<void> atualizarProduto(String nome, Map<String, dynamic> novosDados) async {
    await _firestore
        .collection('produtos')
        .where('nome', isEqualTo: nome)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.update(novosDados);
    }).catchError((error) => print('Erro ao atualizar produto: $error'));
  }

  Future<bool> cadastrarUsuario(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Cadastro bem-sucedido, retorna true
      return true;
    } catch (e) {
      // Se ocorrer uma exceção durante o cadastro, retorna false
      print('Erro ao cadastrar usuário: $e');
      return false;
    }
  }


  Future<bool> logarUsuario(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Autenticação bem-sucedida, retorna true
      return true;
    } catch (e) {
      // Autenticação falhou, retorna false
      print('Erro ao logar usuário: $e');
      return false;
    }
  }

  Future<void> recuperarConta(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Email de recuperação enviado com sucesso
    } catch (e) {
      // Erro ao enviar email de recuperação
      print('Erro ao recuperar conta: $e');
    }
  }

  Future<void> deslogarConta() async {
    await _auth.signOut();
  }
}
