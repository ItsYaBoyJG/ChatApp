import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

final chatPageIndexProvider = StateProvider<int>((ref) => 0);

final friendsPageIndexProvider = StateProvider<int>((ref) => 0);