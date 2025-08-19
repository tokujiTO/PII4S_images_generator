import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _isAnimating = true;
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: _forward ? 1.0 : 1.1, end: _forward ? 1.1 : 1.0),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          builder: (context, scale, _) {
            return Transform.scale(
              scale: scale,
              child: Image.asset('lib/app/assets/verticalColored.png'),
            );
          },
          onEnd: () {
            if (mounted && _isAnimating) {
              setState(() {
                _forward = !_forward;
              });
            } else if (!_isAnimating) {
              Navigator.of(context).pushReplacementNamed('/first');
            }
          },
        ),
      ),
    );
  }
}
