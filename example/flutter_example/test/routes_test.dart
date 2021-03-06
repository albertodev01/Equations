import 'package:equations_solver/routes.dart';
import 'package:equations_solver/routes/home_page.dart';
import 'package:equations_solver/routes/nonlinear_page.dart';
import 'package:equations_solver/routes/polynomial_page.dart';
import 'package:equations_solver/routes/system_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Making sure that route names are consistent', () {
    test('Verifying route names', () {
      expect(RouteGenerator.homePage, equals('/'));
      expect(RouteGenerator.polynomialPage, equals('/polynomials'));
      expect(RouteGenerator.nonlinearPage, equals('/nonlinear'));
      expect(RouteGenerator.systemPage, equals('/system'));
    });

    test('Checking routes health', () {
      // Determines the status of the test
      var success = true;

      // The list of routes to be tested
      const routes = <String>[
        RouteGenerator.homePage,
        RouteGenerator.polynomialPage,
        RouteGenerator.nonlinearPage,
        RouteGenerator.systemPage,
      ];

      try {
        // Making sure no exceptions are thrown inside routes
        for (final route in routes) {
          final setting = RouteSettings(name: route);
          RouteGenerator.generateRoute(setting);
        }
      } on Exception {
        success = false;
      }

      expect(success, true);
    });

    test('Making sure that routes map to a PageRoute instance', () {
      expect(
        RouteGenerator.generateRoute(const RouteSettings(
          name: RouteGenerator.homePage,
        )),
        isA<MaterialPageRoute<HomePage>>(),
      );

      expect(
        RouteGenerator.generateRoute(const RouteSettings(
          name: RouteGenerator.polynomialPage,
        )),
        isA<MaterialPageRoute<PolynomialPage>>(),
      );

      expect(
        RouteGenerator.generateRoute(const RouteSettings(
          name: RouteGenerator.nonlinearPage,
        )),
        isA<MaterialPageRoute<NonlinearPage>>(),
      );

      expect(
        RouteGenerator.generateRoute(const RouteSettings(
          name: RouteGenerator.systemPage,
        )),
        isA<MaterialPageRoute<SystemPage>>(),
      );
    });

    test('Checking the type of the exception thrown', () {
      expect(() {
        RouteGenerator.generateRoute(const RouteSettings(name: ''));
      }, throwsA(isA<RouteException>()));
    });

    test(
        "Making sure that 'RouteException' objects properly define equality"
        ' overrides', () {
      const exception = RouteException('Message');

      expect(exception.message, equals('Message'));
      expect(
        exception,
        equals(const RouteException('Message')),
      );
      expect(
        exception.hashCode,
        equals(const RouteException('Message').hashCode),
      );
    });
  });
}
