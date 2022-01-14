import 'dart:async';

import 'package:masterclass_notification/src/home/stores/home_store.dart';

class HomeController {
  final homeStore = HomeStore();

  final _blocController = StreamController<Duration>();

  HomeController() {
    _blocController.sink.add(Duration(seconds: 0));
  }

  bool trigger = false;

  get time => _blocController.stream;

  Stream<Duration> startTime(int defaultTime) async* {
    int time = Duration(minutes: defaultTime).inSeconds;

    while (trigger) {
      bool isChanged = await homeStore.siteIsChanged();

      for (int i = time; i > 0; i--) {
        _blocController.sink.add(Duration(seconds: time--));
        await Future.delayed(Duration(seconds: 1));
        if (!trigger) break;
      }
    }
  }

  dispose() {
    _blocController.close();
  }
}
