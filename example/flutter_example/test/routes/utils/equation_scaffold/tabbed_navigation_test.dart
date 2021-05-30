import 'package:equations_solver/blocs/navigation_bar/navigation_bar.dart';
import 'package:equations_solver/routes/utils/equation_scaffold/navigation_item.dart';
import 'package:equations_solver/routes/utils/equation_scaffold/tabbed_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_wrapper.dart';

void main() {
  late final TabController controller;

  setUpAll(() {
    controller = TabController(
      length: 2,
      vsync: const TestVSync(),
    );
  });

  group("Testing the 'TabbedNavigationLayout' widget", () {
    testWidgets('Making sure that the widget can be rendered', (tester) async {
      await tester.pumpWidget(MockWrapper(
        child: BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
          child: TabbedNavigationLayout(
            tabController: controller,
            navigationItems: const [
              NavigationItem(
                title: 'Test',
                content: SizedBox(),
              ),
              NavigationItem(
                title: 'Test',
                content: SizedBox(),
              ),
            ],
          ),
        ),
      ));

      final finder = find.byType(TabbedNavigationLayout);
      expect(finder, findsOneWidget);

      expect(find.byType(TabbedNavigationLayout), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('Making sure that tabs can be changed with a controller',
        (tester) async {
      await tester.pumpWidget(MockWrapper(
        child: BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
          child: TabbedNavigationLayout(
            tabController: controller,
            navigationItems: const [
              NavigationItem(
                title: 'Test',
                content: Text('A'),
              ),
              NavigationItem(
                title: 'Test',
                content: Text('B'),
              ),
            ],
          ),
        ),
      ));

      final finder = find.byType(TabbedNavigationLayout);
      final state = tester.state(finder) as TabbedNavigationLayoutState;

      // Start at 0
      expect(controller.index, isZero);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsNothing);

      // Changing the page
      state.changePage(1);
      await tester.pumpAndSettle();

      expect(controller.index, equals(1));
      expect(find.text('B'), findsOneWidget);
      expect(find.text('A'), findsNothing);
    });
  });
}
