import 'package:agendamaq/routers/routers.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/home-fotor.jpg',
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.25,
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: const Text(
                    'AgendaMaq',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: const Text(
                      'Resgistre as atividades de suas máquinas de maneira simples.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouters.CREATEUSER);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AgendaColors.setGreen,
                  ),
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouters.SPLASH_SCREEN);
                },
                child: Text(
                  "Já possui conta? Entrar",
                  style: TextStyle(
                    color: AgendaColors.setGreen,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
