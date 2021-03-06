import 'package:equations/equations.dart';
import 'package:equations/src/utils/exceptions/types/numerical_integration_exception.dart';

/// The "Simpson rule" is a technique for approximating the value of a
/// definite integral.
///
/// This algorithm requires a parameter `m` which indicates how many partitions
/// have to be computed by the algorithm. Note that `n` must be an even number.
class SimpsonRule extends NumericalIntegration {
  /// Expects the [lowerBound] and [upperBound] of the integral.
  ///
  /// The [intervals] variable represents the number of parts in which the
  /// [lowerBound, upperBound] interval has to be split by the algorithm.
  const SimpsonRule({
    required double lowerBound,
    required double upperBound,
    int intervals = 32,
  }) : super(
          lowerBound: lowerBound,
          upperBound: upperBound,
          intervals: intervals,
        );

  @override
  IntegralResults integrate(String function) {
    // Make sure to throw an exception if 'intervals' is odd
    if (intervals % 2 != 0) {
      throw const NumericalIntegrationException('There must be an even number '
          'of partitions.');
    }

    // The 'step' of the algorithm
    final h = (upperBound - lowerBound) / intervals;

    // Keeping track separatedly of the sums of the even and odd series
    var oddSum = 0.0;
    var evenSum = 0.0;

    // The list containing the various guesses of the algorithm
    final guesses = List<double>.filled(intervals, 0);

    // The first iteration
    for (var i = 1; i < intervals; i += 2) {
      oddSum += evaluateFunction(function, lowerBound + i * h);
      guesses[i] = oddSum;
    }

    // The second iteration
    for (var i = 2; i < intervals - 1; i += 2) {
      evenSum += evaluateFunction(function, lowerBound + i * h);
      guesses[i] = oddSum;
    }

    // Returning the result
    final bounds = evaluateFunction(function, lowerBound) +
        evaluateFunction(function, upperBound);

    return IntegralResults(
      guesses: guesses,
      result: (bounds + (2 * evenSum) + (4 * oddSum)) * h / 3,
    );
  }
}
