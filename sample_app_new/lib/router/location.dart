import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_app_new/screens/home_screen.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        child: HomeScreen(),
        key: ValueKey('home'),
      )
    ];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      // ...을 통해 뒷 if 문 리스트와 합침, homelocation(모든 beampage)을 뒤로갈수있는 스택으로 넣기위해 추가
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains('input'))
        BeamPage(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              title: Text(
                'Create new Item',
              ),
            ),
            body: Container(
              color: Colors.green,
            ),
          ),
          key: ValueKey('input'),
        )
    ];
  }

  @override
  List get pathBlueprints => ['/input'];
}
