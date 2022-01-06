import 'package:flutter/material.dart';

class DocumentStreamBuilder<T> extends StatelessWidget {
  const DocumentStreamBuilder({
    required this.stream,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Stream<T?> stream;
  final Widget Function(BuildContext context, T data) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingWidget;
        }
        if (!snapshot.hasData) {
          return noDataWidget;
        }
        final data = snapshot.data as T;
        return builder(context, data);
      },
    );
  }
}

class CollectionStreamBuilder<T> extends StatelessWidget {
  const CollectionStreamBuilder({
    required this.stream,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Stream<List<T>> stream;
  final Widget Function(BuildContext context, List<T> data) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingWidget;
        }
        if (!snapshot.hasData) {
          return noDataWidget;
        }
        final data = snapshot.data!;
        return builder(context, data);
      },
    );
  }
}
