import 'package:bloc_project/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewEntryPage extends StatelessWidget {
  AddNewEntryPage({super.key});

  //Create bloc instance
  final CalculatorBloc calculatorBloc = CalculatorBloc();

  Widget _buildValueButton(String num) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        margin: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            calculatorBloc.input(num);
          },
          child: Text(
            num,
            style: const TextStyle(fontSize: 26.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildSymbolButton(String name, Function() function, bool active) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        margin: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              backgroundColor: active ? Colors.amber : null),
          onPressed: function,
          child: Text(
            name,
            style: const TextStyle(fontSize: 26.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<CalculatorState>(
            stream: calculatorBloc.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              }

              calculatorBloc.log('StreamBuilder', snapshot.data.toString());

              final CalculatorState calculatorState = snapshot.data!;
              final bool validEquation =
                  calculatorState.value1 != null && calculatorState.value2 != null;

              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          calculatorState.display,
                          style: const TextStyle(color: Colors.deepPurple, fontSize: 42),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.amber),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                _buildSymbolButton('C', () => calculatorBloc.clear(), false),
                                const Spacer(),
                                const Spacer(),
                                _buildSymbolButton(
                                    '/',
                                    () => calculatorBloc.useFunction(FuncState.division),
                                    calculatorState.funcState == FuncState.division),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildValueButton('7'),
                                _buildValueButton('8'),
                                _buildValueButton('9'),
                                _buildSymbolButton(
                                    'x',
                                    () => calculatorBloc.useFunction(FuncState.multiplication),
                                    calculatorState.funcState == FuncState.multiplication),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildValueButton('4'),
                                _buildValueButton('5'),
                                _buildValueButton('6'),
                                _buildSymbolButton(
                                    '-',
                                    () => calculatorBloc.useFunction(FuncState.subtraction),
                                    calculatorState.funcState == FuncState.subtraction),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildValueButton('1'),
                                _buildValueButton('2'),
                                _buildValueButton('3'),
                                _buildSymbolButton(
                                    '+',
                                    () => calculatorBloc.useFunction(FuncState.addition),
                                    calculatorState.funcState == FuncState.addition),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildValueButton('0'),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildSymbolButton('.', () {
                                        calculatorBloc.toDecimal();
                                      }, false),
                                      Expanded(
                                        child: Container(
                                            constraints: const BoxConstraints(minHeight: 50),
                                            margin: const EdgeInsets.all(4.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30))),
                                                onPressed: () {
                                                  if (validEquation) {
                                                    calculatorBloc.getResult();
                                                  } else {
                                                    return;
                                                  }
                                                },
                                                //Whether equation is valid
                                                child: validEquation
                                                    ? const Text('=')
                                                    : const Icon(Icons.check))),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
