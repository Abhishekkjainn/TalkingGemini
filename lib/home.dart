import 'package:abhi/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 16, 16, 16),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Lottie.asset('assets/images/gemini.json', reverse: true),
          )
        ],
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    const Color.fromARGB(255, 211, 240, 253),
                    Colors.blue
                  ]),
                  width: 3)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, bottom: 8, top: 8, right: 15),
            child: Text(
              'Gemini',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: HomeScreen(),
    );
  }
}
