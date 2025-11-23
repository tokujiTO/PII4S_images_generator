import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'rename_page.dart';
import 'change_email_page.dart';
import 'delete_account_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key, required this.loginFlow})
    : super(key: key);

  final bool loginFlow;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Web
        if (constraints.maxWidth > 800) {
          return _buildWebLayout(context);
        }
        // mobile
        return _buildMobileLayout(context);
      },
    );
  }

  //web
  Widget _buildWebLayout(BuildContext context) {
    const Color highlightColor = AppColors.yellow;

    Widget currentWebStepWidget;
    switch (_step) {
      case 1:
        currentWebStepWidget = _buildWebStep1(highlightColor);
        break;
      case 2:
        currentWebStepWidget = _buildWebStep2(highlightColor);
        break;
      case 3:
        currentWebStepWidget = _buildWebStep3(highlightColor);
        break;
      default:
        currentWebStepWidget = Container();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          //menu esquerdo
          widget.loginFlow
              ? Container()
              : Container(
                  width: 300,
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildWebMenuItem(
                        text: 'Redefinir nome',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RenamePage(),
                            ),
                          );
                        },
                      ),

                      Material(
                        color: highlightColor,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 24,
                            ),
                            child: const Text(
                              'Redefinir senha',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                      _buildWebMenuItem(
                        text: 'Redefinir e-mail',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChangeEmailPage(),
                            ),
                          );
                        },
                      ),

                      _buildWebMenuItem(
                        text: 'Excluir conta',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DeleteAccountPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

          //conteudo principal
          Expanded(
            child: Stack(
              children: [
                // A. Brilho no topo
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          highlightColor.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // posição do título
                    margin: const EdgeInsets.only(top: 110, left: 60),
                    width: 450, // Largura da linha branca
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: const Text(
                            '\u2006Quer alterar sua senha?',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 0,
                              right: 60,
                            ), // desloca
                            width: 550, // aumenta tamanho
                            height: 2,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // Margem Top maior para ficar abaixo do título
                    margin: const EdgeInsets.only(top: 200),
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: currentWebStepWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebStep1(Color highlightColor) {
    return Column(
      key: const ValueKey<int>(1),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Digite seu novo e-mail para\nefetuarmos a redefinição:',
          style: TextStyle(color: AppColors.white, fontSize: 27, height: 1.5),
          textAlign: TextAlign.center, // Texto centralizado no bloco central
        ),
        const SizedBox(height: 40),
        CustomTextField(focusBorder: AppColors.yellow, labelText: 'E-mail'),
        const SizedBox(height: 20),
        _buildWebButton('Redefinir', highlightColor, () {
          setState(() => _step = 2);
        }),
      ],
    );
  }

  Widget _buildWebStep2(Color highlightColor) {
    return Column(
      key: const ValueKey<int>(2),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Digite o código que enviamos\nagora para:',
          style: TextStyle(color: AppColors.white, fontSize: 27, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text(
          'exemplo@gmail.com',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        const Text(
          '_ _ _ _ _ _',
          style: TextStyle(
            color: AppColors.gray,
            fontSize: 40,
            letterSpacing: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: _buildWebButton('Enviar', highlightColor, () {
            setState(() => _step = 3);
          }),
        ),
      ],
    );
  }

  Widget _buildWebStep3(Color highlightColor) {
    return Column(
      key: const ValueKey<int>(3),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Digite sua nova senha:',
            style: TextStyle(color: AppColors.white, fontSize: 27),
          ),
        ),
        const SizedBox(height: 40),
        CustomTextField(
          focusBorder: AppColors.yellow,
          labelText: 'Senha',
          isPassword: true,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          focusBorder: AppColors.yellow,
          labelText: 'Confirme sua senha',
          isPassword: true,
        ),
        const SizedBox(height: 20),
        _buildWebButton('Redefinir', highlightColor, () {
          // Ação final
        }),
      ],
    );
  }

  Widget _buildWebButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: color, fontSize: 20)),
      ),
    );
  }

  Widget _buildWebMenuItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.white, width: 2),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: AppColors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  //mobile
  Widget _buildMobileLayout(BuildContext context) {
    const Color highlightColor = AppColors.yellow;

    Widget currentStepWidget;
    switch (_step) {
      case 1:
        currentStepWidget = _buildStep1(highlightColor);
        break;
      case 2:
        currentStepWidget = _buildStep2(highlightColor);
        break;
      case 3:
        currentStepWidget = _buildStep3(highlightColor);
        break;
      default:
        currentStepWidget = Container();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [highlightColor.withOpacity(1.0), Colors.transparent],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: currentStepWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(Color color) {
    return Column(
      key: const ValueKey<int>(1),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Quer alterar sua senha?',
          style: TextStyle(color: AppColors.white, fontSize: 25),
        ),
        const SizedBox(height: 10),
        Container(height: 2, color: AppColors.white),
        const SizedBox(height: 15),
        const Text(
          'Digite seu novo e-mail para efetuarmos a redefinição:',
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
        const SizedBox(height: 20),
        CustomTextField(focusBorder: AppColors.yellow, labelText: 'E-mail'),
        const SizedBox(height: 20),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextButton(
            onPressed: () {
              setState(() => _step = 2);
            },
            child: Text(
              'Redefinir',
              style: TextStyle(color: color, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2(Color color) {
    return Column(
      key: const ValueKey<int>(2),
      crossAxisAlignment: CrossAxisAlignment.start, // título à esquerda
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quer alterar sua senha?',
            style: TextStyle(color: AppColors.white, fontSize: 25),
          ),
        ),

        const SizedBox(height: 10),
        Container(height: 2, color: AppColors.white),
        const SizedBox(height: 15),

        Center(
          child: Column(
            children: const [
              Text(
                'Digite o código que enviamos agora para:',
                style: TextStyle(color: AppColors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'exemplo@gmail.com',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                '_ _ _ _ _ _',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30,
                  letterSpacing: 10,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60),
            ],
          ),
        ),

        Center(
          child: Container(
            height: 55,
            width: 700,
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextButton(
              onPressed: () {
                setState(() => _step = 3);
              },
              child: Text(
                'Enviar',
                style: TextStyle(color: color, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(Color color) {
    return Column(
      key: const ValueKey<int>(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quer alterar sua senha?',
            style: TextStyle(color: AppColors.white, fontSize: 25),
          ),
        ),

        const SizedBox(height: 10),
        Container(height: 2, color: AppColors.white),
        const SizedBox(height: 40),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Digite sua nova senha:',
                style: TextStyle(color: AppColors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              SizedBox(width: 700, child: _buildPasswordField('Senha')),
              const SizedBox(height: 20),
              SizedBox(
                width: 700,
                child: _buildPasswordField('Confirme sua senha'),
              ),

              const SizedBox(height: 30),

              Container(
                height: 50,
                width: 700,
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Redefinir',
                    style: TextStyle(color: color, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String hint) {
    return CustomTextField(
      focusBorder: AppColors.yellow,
      labelText: hint,
      isPassword: true,
    );
  }
}
