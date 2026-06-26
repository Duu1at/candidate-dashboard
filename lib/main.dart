import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox<String>('candidates'),
    Hive.openBox<String>('statuses'),
  ]);

  configureDependencies();

  runApp(const App());
}
