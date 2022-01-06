import 'package:flutter/material.dart';

class DocumentFutureBuilder<T> extends StatelessWidget {
  const DocumentFutureBuilder({
    required this.future,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Future<T?> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: future,
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

class CollectionFutureBuilder<T> extends StatelessWidget {
  const CollectionFutureBuilder({
    required this.future,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Future<List<T>> future;
  final Widget Function(BuildContext context, List<T> data) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
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
