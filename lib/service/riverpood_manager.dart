import 'package:bilgi_barismasi/notifier_pages/home_page_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier_pages/create_dogruyanlis_shape_notifier.dart';
import '../notifier_pages/create_quiz_shape_notifier.dart';
import '../notifier_pages/live_session_quiz_shape_notifier.dart';

final myDogruYanlisShapeProvider =
    ChangeNotifierProvider<MyDogruYanlisShapeNotifier>((ref) {
  return MyDogruYanlisShapeNotifier();
});

final myQuizShapeProvider =
    ChangeNotifierProvider<MyQuizShapeNotifier>((ref) => MyQuizShapeNotifier());

// final myLiveSessionDogruYanlisShapeNotifier =
// ChangeNotifierProvider<MyLiveSessionDogruYanlisShapeNotifier>((ref) => MyLiveSessionDogruYanlisShapeNotifier());

final myLiveSessionQuizShapeNotifier =
    ChangeNotifierProvider<MyLiveSessionQuizShapeNotifier>(
        (ref) => MyLiveSessionQuizShapeNotifier());

final homePageProvider =
    ChangeNotifierProvider<HomePageNotifier>((ref) => HomePageNotifier());
