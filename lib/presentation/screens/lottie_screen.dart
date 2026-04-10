import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LottieScreen extends StatelessWidget {
  const LottieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/lottie/Wallet.json",
          height: 500,
          width: 500,
          // controller: _controller,
          // onLoaded: (composition) {
          // _controller
          // ..duration = Durations.extralong4
          // ..repeat();
          // },
        ),
      ),
    );
  }
}
