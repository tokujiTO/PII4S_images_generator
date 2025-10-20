import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class RenamePage extends StatelessWidget {
  const RenamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color highlightColor = AppColors.yellow; 

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Digite seu novo nome:',
              style: TextStyle(color: AppColors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: 'Nome',
                hintStyle: const TextStyle(color: AppColors.gray, fontSize: 15),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.person, color: AppColors.gray),
                ),
              ),
              style: const TextStyle(color: AppColors.background),
            ),
            const SizedBox(height: 40),
            // Botão "Redefinir"
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.yellow, width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextButton(
                onPressed: () {
                },
                child: const Text(
                  'Redefinir',
                  style: TextStyle(color: AppColors.yellow, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}