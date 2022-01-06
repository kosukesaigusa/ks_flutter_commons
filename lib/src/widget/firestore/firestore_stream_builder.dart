import 'package:flutter/material.dart';

class DocumentStreamBuilder<T> extends StatelessWidget {
  const DocumentStreamBuilder({
    required this.documentStream,
    required this.child,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Stream<T?> documentStream;
  final Widget Function(BuildContext context, T data) child;
  final Widget waitingWidget;
  final Widget noDataWidget;

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
        return child(context, data);
      },
    );
  }
}

class CollectionStreamBuilder<T> extends StatelessWidget {
  const CollectionStreamBuilder({
    required this.collectionStream,
    required this.child,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Stream<List<T>> collectionStream;
  final Widget Function(BuildContext context, List<T> data) child;
  final Widget waitingWidget;
  final Widget noDataWidget;

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
        return child(context, data);
      },
    );
  }
}
