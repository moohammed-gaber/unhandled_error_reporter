import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

void main() {
  _scheduleAsync();
/*
  Chain.capture(() {
   return _scheduleAsync();
  },


    onError: (error, stackTrace) {
*/
/*
    print('Caught error: $error');
    print('Stack trace: $stackTrace');
*/ /*

  }, );
*/
}

void _scheduleAsync() {
  Future.delayed(const Duration(seconds: 1)).then((_) => _runAsync());
}

void _runAsync() {
  try {
    throw 'oh no!';
  } catch (e,stack) {
    final x= Chain.forTrace(stack);

/*
    print(stack);
    print('---------');
    print(x.terse);
    print('---------');
*/

    // print(x.traces[0].toString());
    print(x.terse.terse.terse.terse);
/*
    print('---------');

    print(x.toTrace());
*/


  }
}
