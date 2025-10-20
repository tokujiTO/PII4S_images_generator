import 'package:flutter/material.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color deleteColor = Color(0xFFE91E63); 

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: deleteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Excluir conta',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const Text(
              'Tem certeza que deseja excluir sua conta?',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Isso apagará permanentemente todas as suas informações.',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            // Botão "Excluir"
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: deleteColor, width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextButton(
                onPressed: () {
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: deleteColor, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Volta para a tela anterior
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}