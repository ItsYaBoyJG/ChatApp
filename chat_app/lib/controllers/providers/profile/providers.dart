import 'package:chat_app/models/enums/data_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedProfileImageDataProvider = StateProvider((ref) => DataType.snaps);
