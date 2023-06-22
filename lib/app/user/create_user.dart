import 'package:agendamaq/app/components/password_form.dart';
import 'package:agendamaq/app/components/text_form.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // implementar a lógica de envio do formulário para o backend
      // ou realizar qualquer outra ação desejada com os dados inseridos no formulário.

      final String name = _nameController.text;
      final String email = _emailController.text;
      final String telefone = _telefoneController.text;
      final String endereco = _enderecoController.text;
      final String password = _passwordController.text;

      // Exemplo de exibição dos dados no console
      print('Nome: $name');
      print('Email: $email');
      print('Senha: $password');
      print('telefone: $telefone');
      print('endereco: $endereco');

      // Reinicia os campos do formulário
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TextFormFieldAdd(_nameController, 'Nome'),
              const SizedBox(height: 20),
              TextFormFieldAdd(_emailController, 'Email'),
              const SizedBox(height: 20),
              TextFormFieldAdd(_telefoneController, 'Telefone'),
              const SizedBox(height: 20),
              PassFormFieldAdd(_passwordController, 'Senha'),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AgendaColors.setGreen),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
