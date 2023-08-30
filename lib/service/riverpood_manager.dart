import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier_pages/create_dogruyanlis_shape_notifier.dart';

final myDogruYanlisShapeProvider =
    ChangeNotifierProvider<MyDogruYanlisShapeNotifier>((ref) {
  return MyDogruYanlisShapeNotifier();
});
