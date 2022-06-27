import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_app_new/constants/common_size.dart';
import 'package:sample_app_new/repo/user_service.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      final imgSize = size.width / 4;

      return FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 2),
        ),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(
                milliseconds: 1000,
              ),
              child: (snapshot.connectionState != ConnectionState.done)
                  ? _shimmerListView(imgSize)
                  : _listView(imgSize));
        },
      );
      // return _listView(imgSize);
    });
  }

  ListView _listView(double imgSize) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          height: common_padding * 2 + 1,
          thickness: 1,
          color: Colors.grey[200],
          indent: common_sm_padding,
          endIndent: common_sm_padding,
        );
      },
      padding: EdgeInsets.all(common_padding),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            UserService().firestoreTest();
          },
          child: SizedBox(
            height: imgSize,
            child: Row(
              children: [
                SizedBox(
                  height: imgSize,
                  width: imgSize,
                  child: ExtendedImage.network(
                    'https://picsum.photos/100',
                    // shape 을 넣어줘야 보더 컨트롤 가능 circle:원 모양(radius 불필요)
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  width: common_sm_padding,
                  height: common_sm_padding,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'work',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        '53일전',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text('5,000원'),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 18,
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.chat_bubble_2,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '30',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '40',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding * 2 + 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: common_sm_padding,
            endIndent: common_sm_padding,
          );
        },
        padding: EdgeInsets.all(common_padding),
        itemBuilder: (context, index) {
          return SizedBox(
            height: imgSize,
            child: Row(
              children: [
                Container(
                  height: imgSize,
                  width: imgSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  width: common_sm_padding,
                  height: common_sm_padding,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        height: 14,
                        width: 150,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        height: 12,
                        width: 80,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        height: 14,
                        width: 100,
                      ),
                      Expanded(
                        child: Container(
                            // color: Colors.white,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            height: 14,
                            width: 80,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
