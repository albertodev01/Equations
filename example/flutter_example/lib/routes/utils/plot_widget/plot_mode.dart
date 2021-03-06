import 'package:equatable/equatable.dart';
import 'package:equations/equations.dart';

/// This class provides the ability to evaluate a function on a given point. The
/// [equation] object dependency defines the behavior of [evaluateOn].
abstract class PlotMode<T> extends Equatable {
  /// The equation object that defines the [evaluateOn] method.
  final T equation;

  /// Creates an instance of [PlotMode]
  const PlotMode(this.equation);

  /// Evaluates the [equation] on the specified real number [x].
  double evaluateOn(double x);

  @override
  List<Object?> get props => [equation];
}

/// Polynomial functions evaluator.
class PolynomialPlot extends PlotMode<Algebraic> {
  /// Creates an instance of [PolynomialPlot].
  const PolynomialPlot({
    required Algebraic algebraic,
  }) : super(algebraic);

  @override
  double evaluateOn(double x) => equation.realEvaluateOn(x).real;
}

/// Real functions evaluator.
class NonlinearPlot extends PlotMode<NonLinear> {
  /// Creates an instance of [NonlinearPlot].
  const NonlinearPlot({
    required NonLinear nonLinear,
  }) : super(nonLinear);

  @override
  double evaluateOn(double x) => equation.evaluateOn(x) as double;
}
