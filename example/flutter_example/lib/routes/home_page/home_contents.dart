import 'package:flutter/material.dart';
import 'package:equations_solver/routes.dart';
import 'package:equations_solver/routes/home_page/card_containers.dart';
import 'package:equations_solver/routes/utils/sections_logos.dart';
import 'package:equations_solver/localization/localization.dart';

/// Contains a series of tiles, represented by a [CardContainer] widget, that
/// route the user to various pages
class HomeContents extends StatelessWidget {
  /// Creates a [HomeContents] widget.
  const HomeContents();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardContainer(
            key: const Key('PolynomialLogo-Container'),
            title: context.l10n.polynomials,
            image: const PolynomialLogo(),
            onTap: () => Navigator.of(context).pushNamed(
              RouteGenerator.polynomialPage,
            ),
          ),
          CardContainer(
            key: const Key('NonlinearLogo-Container'),
            title: context.l10n.functions,
            image: const NonlinearLogo(),
            onTap: () => Navigator.of(context).pushNamed(
              RouteGenerator.nonlinearPage,
            ),
          ),
          CardContainer(
            key: const Key('SystemsLogo-Container'),
            title: context.l10n.systems,
            image: const SystemsLogo(),
            onTap: () => Navigator.of(context).pushNamed(
              RouteGenerator.systemPage,
            ),
          ),
          /*CardContainer(
            title: context.l10n.integrals,
            image: const IntegralLogo(),
            onTap: () {},
          ),*/
        ],
      ),
    );
  }
}
