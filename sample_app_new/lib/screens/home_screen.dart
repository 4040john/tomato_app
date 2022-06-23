import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app_new/screens/home/itmes_page.dart';
import 'package:sample_app_new/states/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '성남동',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(
              CupertinoIcons.nosign,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.text_justify,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          ItemsPage(),
          Container(
            color: Colors.accents[3],
          ),
          Container(
            color: Colors.accents[6],
          ),
          Container(
            color: Colors.accents[9],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Colors.white,
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 0
                  ? 'asset/icons/home_black.png'
                  : 'asset/icons/home.png'),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 1
                  ? 'asset/icons/marker_black.png'
                  : 'asset/icons/marker.png'),
            ),
            label: '내근처',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 2
                  ? 'asset/icons/comments_black.png'
                  : 'asset/icons/comments.png'),
            ),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 3
                  ? 'asset/icons/tomato_color.png'
                  : 'asset/icons/tomato.png'),
            ),
            label: '내 정보',
          ),
        ],
      ),
    );
  }
}
