import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class InitialIntroductionScreen extends StatelessWidget {
  const InitialIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ここでIntroductionScreenのライブラリーを呼び出している
        child: IntroductionScreen(
          scrollPhysics: const BouncingScrollPhysics(),
          pages: [
            PageViewModel(
              // \nは改行を意味しているよ！
              title: '',
              body: '',
              decoration: const PageDecoration(
                imageFlex: 15,
                imagePadding: EdgeInsets.zero,
              ),
              image:
                  Image.asset('assets/image/introduction/introduction_1.png'),
            ),
            PageViewModel(
              title: '',
              body: '',
              decoration: const PageDecoration(
                imageFlex: 15,
                imagePadding: EdgeInsets.zero,
              ),
              image:
                  Image.asset('assets/image/introduction/introduction_2.png'),
            ),
            PageViewModel(
              title: '',
              body: '',
              decoration: const PageDecoration(
                imageFlex: 15,
                imagePadding: EdgeInsets.zero,
              ),
              image:
                  Image.asset('assets/image/introduction/introduction_3.png'),
            ),
          ],
          onDone: () async => Navigator.pop(context),
          showBackButton: true,
          next: const Icon(Icons.arrow_forward_ios),
          back: const Icon(Icons.arrow_back_ios),
          done: const Text(
            'OK!',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            // ここの大きさを変更することで
            // 現在の位置を表しているマーカーのUIが変更するよ!
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
