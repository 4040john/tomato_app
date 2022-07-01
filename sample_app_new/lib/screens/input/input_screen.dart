import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:sample_app_new/constants/common_size.dart';
import 'package:sample_app_new/screens/input/multi_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var _divider = Divider(
    height: 1,
    color: Colors.grey[350],
    thickness: 1,
    indent: common_padding,
    endIndent: common_padding,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            context.beamBack();
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
          child: Text(
            '뒤로',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        title: Text(
          '중고거래 글쓰기',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
            child: Text(
              '완료',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          MultiImageSelcet(),
          _divider,
          TextFormField(
            decoration: InputDecoration(
              hintText: '글제목',
              contentPadding: EdgeInsets.symmetric(
                horizontal: common_padding,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          _divider,
          ListTile(
            title: Text('선택'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
          ),
          _divider,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '얼마에 파시겠어요?',
                    icon: Icon(Icons.camera),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  primary: Colors.black54,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.black54,
                ),
                label: Text(
                  '가격제안 받기',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
