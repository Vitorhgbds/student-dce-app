import 'package:flutter/material.dart';
import 'package:meia_entrada/src/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  usePathUrlStrategy();
  await dotenv.load();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
