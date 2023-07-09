import 'dart:convert';

import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AgendaColors.setGreen,
                    ),
                  ),
                ),
                controller: _emailController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AgendaColors.setGreen,
                    ),
                  ),
                ),
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'ESQUECI A SENHA',
                      style:
                          TextStyle(color: AgendaColors.setGreen, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AgendaColors.setGreen),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'ENTRAR',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    var body = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    final response = await http
        .post(Uri.parse('http://192.168.0.135:8000/api/token/'), body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> token = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access', 'Bearer ${token['access'].toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login feito com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pushReplacementNamed(AppRouters.HOME);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou senha incorretos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
