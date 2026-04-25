import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return Directory.systemTemp.path;
        });
    await GetStorage.init();
  });

  testWidgets('Food app starts on the home screen', (
    WidgetTester tester,
  ) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await GetStorage().erase();

    await tester.pumpWidget(const FoodApp());
    await tester.pump();
    expect(find.text('TasteTrail'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.textContaining('Good morning'), findsOneWidget);
    expect(find.text('Popular near you'), findsOneWidget);
  });
}
