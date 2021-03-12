import 'dart:async';

class CalculatorRepository {
  int _calculator;

  Future<void> fetchList() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );
    _calculator = 999;
  }

  int get data => _calculator;
}
