import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../constants/common_size.dart';

class MultiImageSelcet extends StatelessWidget {
  const MultiImageSelcet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //가로 사이즈를 가져오기위해 LayoutBuilder 사용
    return LayoutBuilder(
      builder: (context, constraints) {
        Size _size = MediaQuery.of(context).size;
        var imageSize = (_size.width / 3) - common_padding * 2;
        var imageCorner = 16.0;

        return SizedBox(
          height: _size.width / 3,
          width: _size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Container(
                  width: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(imageCorner),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.grey,
                      ),
                      Text(
                        '0/10',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
              //개별 아이템 이후 리스트를 뿌리고 싶을때 ... 사용
              ...List.generate(
                20,
                (index) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: common_padding,
                        bottom: common_padding,
                        right: common_padding,
                      ),
                      child: ExtendedImage.network(
                        'https://picsum.photos/100',
                        width: imageSize,
                        height: imageSize,
                        borderRadius: BorderRadius.circular(imageCorner),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 40,
                      child: IconButton(
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {},
                        icon: Icon(Icons.remove_circle),
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
