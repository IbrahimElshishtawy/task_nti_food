import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

import 'package:food/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await GetStorage.init();
  });

  testWidgets('Food app starts on the home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FoodApp());
    await tester.pump();

    expect(find.textContaining('Good morning'), findsOneWidget);
    expect(find.text('Popular near you'), findsOneWidget);
  });
}
