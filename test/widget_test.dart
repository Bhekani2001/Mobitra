import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobitra/main.dart';

void main() {
  testWidgets('App loads and shows splash screen image', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Image), findsOneWidget);

    final imageWidget = tester.widget<Image>(find.byType(Image));
    final imageProvider = imageWidget.image;

    expect(imageProvider, isA<AssetImage>());
    final assetImage = imageProvider as AssetImage;
    expect(assetImage.assetName, 'lib/assets/MobitraLogo.png');

    await tester.pump(const Duration(seconds: 25));
    await tester.pumpAndSettle();

    expect(find.text('Mobitra'), findsOneWidget);
  });
}
