import 'package:flutter/material.dart';

class DocumentStreamBuilder<T, A> extends StatelessWidget {
  const DocumentStreamBuilder({
    required this.documentStream,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
    this.args,
  });
  final Stream<T?> documentStream;
  final Widget Function(BuildContext context, T data, {A? args}) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;
  final A? args;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: documentStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        final data = snapshot.data as T;
        return builder(context, data, args: args);
      },
    );
  }
}

class CollectionStreamBuilder<T, A> extends StatelessWidget {
  const CollectionStreamBuilder({
    required this.collectionStream,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
    this.args,
  });
  final Stream<List<T>> collectionStream;
  final Widget Function(BuildContext context, List<T> data, {A? args}) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;
  final A? args;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: collectionStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        final data = snapshot.data!;
        return builder(context, data, args: args);
      },
    );
  }
}
