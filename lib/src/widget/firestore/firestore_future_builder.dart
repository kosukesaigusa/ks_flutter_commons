import 'package:flutter/material.dart';

class DocumentFutureBuilder<T> extends StatelessWidget {
  const DocumentFutureBuilder({
    required this.fetchDocument,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Future<T?> fetchDocument;
  final Widget Function(BuildContext context, T data) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: fetchDocument,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        final data = snapshot.data as T;
        return builder(context, data);
      },
    );
  }
}

class CollectionFutureBuilder<T> extends StatelessWidget {
  const CollectionFutureBuilder({
    required this.fetchCollection,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  });
  final Future<List<T>> fetchCollection;
  final Widget Function(BuildContext context, List<T> data) builder;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: fetchCollection,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        final data = snapshot.data!;
        return builder(context, data);
      },
    );
  }
}
