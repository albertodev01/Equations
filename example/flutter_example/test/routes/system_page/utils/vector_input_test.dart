import 'package:equations_solver/routes/system_page/system_input_field.dart';
import 'package:equations_solver/routes/system_page/utils/vector_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../mock_wrapper.dart';

void main() {
  group("Testing the 'VectorInput' widget", () {
    testWidgets('Making sure that the widget is rendered', (tester) async {
      await tester.pumpWidget(MockWrapper(
        child: VectorInput(
          vectorControllers: [
            TextEditingController(),
            TextEditingController(),
          ],
          vectorSize: 2,
        ),
      ));

      expect(find.byType(VectorInput), findsOneWidget);
      expect(find.byType(SystemInputField), findsNWidgets(2));
    });

    testGoldens('VectorInput', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'MatrixInput - 2x2',
          VectorInput(
            vectorControllers: [
              TextEditingController(text: '1'),
              TextEditingController(text: '2'),
            ],
            vectorSize: 2,
          ),
        )
        ..addScenario(
          'MatrixInput - 3x3',
          VectorInput(
            vectorControllers: [
              TextEditingController(text: '1'),
              TextEditingController(text: '2'),
              TextEditingController(text: '3'),
            ],
            vectorSize: 3,
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: (child) => MockWrapper(
          child: child,
        ),
        surfaceSize: const Size(300, 400),
      );
      await screenMatchesGolden(tester, 'vector_input');
    });
  });
}
