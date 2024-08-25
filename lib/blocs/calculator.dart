import 'dart:async';
import 'package:bloc_project/bloc/bloc.dart';
import 'package:bloc_project/utiles/logger.dart';
import 'package:rxdart/rxdart.dart';

//TODO: Rewrite this Bloc someday for clean code

class CalculatorBloc extends Bloc {
  final BehaviorSubject<CalculatorState> _stream = BehaviorSubject<CalculatorState>.seeded(
      CalculatorState(display: '0', funcState: FuncState.none));

  Stream<CalculatorState> get stream => _stream;

  @override
  void dispose() {
    _stream.close();
  }

  @override
  void log(String title, String message) => logger('CalculatorBloc', title, message);

  void clear() {
    _stream.add(CalculatorState(display: '0', funcState: FuncState.none));
  }

  void input(String input) {
    final CalculatorState prevState = _stream.value;
    final CalculatorState newState = CalculatorState.clone(prevState);
    switch (prevState.funcState) {
      case FuncState.none:
        if (prevState.display == '0') {
          newState.display = input;
        } else {
          newState.display = prevState.display + input;
        }
        newState.value1 = _stringToNum(newState.display);
        break;
      case FuncState.calculated:
        newState.display = input;
        newState.funcState = FuncState.none;
        break;
      default:
        if (prevState.value2 == null && prevState.value1 != null) {
          newState.display = input;
        } else {
          newState.display = prevState.display + input;
        }
        newState.value2 = _stringToNum(newState.display);
    }

    _stream.add(newState);
  }

  void useFunction(FuncState function) {
    final CalculatorState prevState = _stream.value;

    if (prevState.value1 == null) {
      log('useFunction', 'Value1 can not be null');
      return;
    }

    if (prevState.value1 != null && prevState.value2 != null) {}

    final CalculatorState newState = CalculatorState.clone(prevState);
    newState.funcState = function;

    _stream.add(newState);
  }

  void toDecimal() {

  }

  void getResult() {
    final num result;

    switch (_stream.value.funcState) {
      case FuncState.addition:
        result = _addition();
        break;
      case FuncState.subtraction:
        result = _subtraction();
        break;
      case FuncState.multiplication:
        result = _multiplication();
        break;
      case FuncState.division:
        result = _division();
        break;
      default:
        return;
    }
    _stream.add(CalculatorState(
        value1: result, value2: null, funcState: FuncState.calculated, display: result.toString()));
  }

  num _addition() {
    return _stream.value.value1! + _stream.value.value2!;
  }

  num _subtraction() {
    return _stream.value.value1! - _stream.value.value2!;
  }

  num _multiplication() {
    return _stream.value.value1! * _stream.value.value2!;
  }

  num _division() {
    return _stream.value.value1! / _stream.value.value2!;
  }

  num _stringToNum(String str) {
    if (int.tryParse(str) != null) {
      return int.parse(str);
    }

    return double.parse(str);
  }
}

class CalculatorState {
  num? value1;
  num? value2;
  String display;
  FuncState funcState;

  CalculatorState({
    this.value1,
    this.value2,
    required this.funcState,
    required this.display,
  });

  static CalculatorState clone(CalculatorState prev) {
    return CalculatorState(
        value1: prev.value1, value2: prev.value2, display: prev.display, funcState: prev.funcState);
  }

  @override
  String toString() {
    return '{ display: $display, value1: $value1, value2: $value2, state: $funcState }';
  }
}

enum FuncState { none, addition, subtraction, multiplication, division, toDecimal, calculated }
