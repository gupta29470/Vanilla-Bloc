import 'dart:async';

import 'package:counter_app_bloc/bloc/counter_event.dart';

class CounterBloc {
  int _counter = 0;
  final _counterStateController = StreamController<int>();
  final _counterEventController = StreamController<CounterEvent>();

  // for adding value in stream
  StreamSink<int> get _inCounter => _counterStateController.sink;

  // expose to UI to get value from stream
  Stream<int> get getCounterValue => _counterStateController.stream;

  // expose to UI to sink value in stream
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(emitEvent);
  }
  void emitEvent(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
