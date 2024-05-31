import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';

final serviceProvider = Provider<BaseCRUDDataBaseServices>((ref) {
  return NetWorkDataBaseService();
});
