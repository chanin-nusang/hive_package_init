import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Helpers/starwars_repo.dart';
import 'app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PeopleAdapter());
  await Hive.openBox('starwars');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
