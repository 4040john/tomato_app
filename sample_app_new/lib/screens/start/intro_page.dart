import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app_new/states/user_provider.dart';
import 'package:sample_app_new/utils/logger.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  // void onButtonClick() {
  //
  // }

  @override
  Widget build(BuildContext context) {
    //화면 사이즈가 바뀔떄마다 리빌드
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;

        final imgSize = size.width - 32;
        final sizeOfPosing = imgSize * 0.1;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '토마토마켓',
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: imgSize,
                  height: imgSize,
                  child: Stack(
                    children: [
                      ExtendedImage.asset('asset/image/carrot_intro.png'),
                      Positioned(
                        width: sizeOfPosing,
                        height: sizeOfPosing,
                        left: imgSize * 0.45,
                        top: imgSize * 0.45,
                        child: ExtendedImage.asset(
                            'asset/image/carrot_intro_pos.png'),
                      ),
                    ],
                  ),
                ),
                Text(
                  '우리 동네 중고 직거래 토마토마켓',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '토마토 마켓은 동네 직거래 마켓이에요.\n내 동네를 설정하고 시작해보세요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        context.read<PageController>().animateToPage(
                          1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        logger.d('on Text Button Clicked!!!');

                        // var response = await Dio().get('https://randomuser.me/api/');
                        // logger.d('response::: $response');
                      },
                      child: Text(
                        '내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
