import 'package:flutter_test/flutter_test.dart';
import 'package:net_prep/features/results/results_screen.dart';

void main() {
  test('NUST aggregate weighs NET 75, HSSC 15, SSC 10', () {
    expect(netAggregate(netPercent: 70, ssc: 90, hssc: 80), closeTo(73.5, 1e-9));
    expect(netAggregate(netPercent: 1.5, ssc: 85, hssc: 90), closeTo(23.125, 1e-9));
  });
}
