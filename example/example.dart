library example;

import 'package:built_redux/built_redux.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter/material.dart' hide Builder;

import 'counter.dart';

void main() {
  // create the store
  final store = new Store(
    reducerBuilder.build(),
    new Counter(),
    new CounterActions(),
  );

  runApp(new ConnectionExample(store));
  // or comment the line above and uncomment the line below
  // runApp(new ConnectorExample(store));
}

/// an example using `StoreConnection`
class ConnectionExample extends StatelessWidget {
  final Store<Counter, CounterBuilder, CounterActions> store;

  ConnectionExample(this.store);

  @override
  Widget build(BuildContext context) => new MaterialApp(
        title: 'flutter_built_redux_test',
        home: new ReduxProvider(
          store: store,
          child: new StoreConnection<Counter, CounterActions, int>(
            connect: (state) => state.count,
            builder: (BuildContext context, int count, CounterActions actions) {
              return new Scaffold(
                body: new Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => actions.increment,
                      child: new Text('Increment'),
                    ),
                    new Text('Count: $count'),
                  ],
                ),
              );
            },
          ),
        ),
      );
}

/// an example using a widget that implements `StoreConnector`
class ConnectorExample extends StatelessWidget {
  final Store<Counter, CounterBuilder, CounterActions> store;

  ConnectorExample(this.store);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'flutter_built_redux_test',
      home: new ReduxProvider(
        store: store,
        child: new CounterWidget(),
      ),
    );
  }
}

/// [CounterWidget] impelments [StoreConnector] manually
class CounterWidget extends StoreConnector<Counter, CounterActions, int> {
  CounterWidget();

  @override
  int connect(Counter state) => state.count;

  @override
  Widget build(BuildContext context, int count, CounterActions actions) => new Scaffold(
        body: new Row(
          children: <Widget>[
            new TextButton(
              onPressed: () => actions.increment,
              child: new Text('Increment'),
            ),
            new Text('Count: $count'),
          ],
        ),
      );
}

// Built redux counter state, actions, and reducer

