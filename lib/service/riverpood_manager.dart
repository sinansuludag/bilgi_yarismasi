import 'package:bilgi_barismasi/notifier_pages/create_quiz_notifier.dart';
import 'package:bilgi_barismasi/notifier_pages/home_page_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier_pages/create_quiz_shape_notifier.dart';
import '../notifier_pages/live_session_quiz_shape_notifier.dart';
import '../notifier_pages/profil_screen_page_notifier.dart';

final myQuizShapeProvider =
    ChangeNotifierProvider<MyQuizShapeNotifier>((ref) => MyQuizShapeNotifier());
final myQuizCreateProvider =
    ChangeNotifierProvider<CreateQuizNotifier>((ref) => CreateQuizNotifier());

final myLiveSessionQuizShapeProvider =
    ChangeNotifierProvider<MyLiveSessionQuizShapeNotifier>(
        (ref) => MyLiveSessionQuizShapeNotifier());

final homePageProvider =
    ChangeNotifierProvider<HomePageNotifier>((ref) => HomePageNotifier());

final myProfilScreenProvider=ChangeNotifierProvider<MyProfilScreenPageNotifier>((ref) => MyProfilScreenPageNotifier());
