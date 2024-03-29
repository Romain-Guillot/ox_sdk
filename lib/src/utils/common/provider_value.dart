import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';

sealed class ProviderValue<T, E> {}

class LoadingValue<T, E> extends ProviderValue<T, E> {}

class ErrorValue<T, E> extends ProviderValue<T, E> {
  ErrorValue(this.error);

  final E error;
}

class DataValue<T, E> extends ProviderValue<T, E> {
  DataValue(this.value);

  final T value;
}

/// [EmptyDataWidget]
/// [ErrorDataWidget]
/// [LoadingDataWidget]
class ProviderValueBuilder<T, K> extends StatelessWidget {
  const ProviderValueBuilder({
    Key? key,
    required this.value,
    required this.dataBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.emptyDataBuilder,
    this.isSliver = false,
    this.refreshButton,
  }) : super(key: key);

  final ProviderValue<T, K> value;

  final bool isSliver;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, K? error)? errorBuilder;
  final Widget Function(BuildContext context, T value) dataBuilder;
  final Widget Function(BuildContext context)? emptyDataBuilder;
  final Widget? refreshButton;

  @override
  Widget build(BuildContext context) {
    final loadingBuilder = this.loadingBuilder;
    final errorBuilder = this.errorBuilder;

    Widget child;

    switch (value) {
      case LoadingValue():
        if (loadingBuilder != null) {
          child = loadingBuilder(context);
        } else {
          child = const OLoadingIndicator();
        }
        break;
      case ErrorValue():
        final error = (value as ErrorValue).error;
        if (errorBuilder != null) {
          child = errorBuilder(context, error);
        } else {
          child = DefaultErrorWidget(
            refreshButton: refreshButton,
            error: error.toString(),
          );
        }
        break;

      case DataValue():
        final data = (value as DataValue).value;
        if (emptyDataBuilder != null && !data.hasData) {
          child = emptyDataBuilder!.call(context);
        } else {
          child = dataBuilder(context, data);
        }
        break;
    }

    if (isSliver) {
      child = SliverToBoxAdapter(child: child);
    }

    return child;
  }
}

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({
    Key? key,
    required this.error,
    this.refreshButton,
  }) : super(key: key);

  final String? error;
  final Widget? refreshButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(error!),
          ),
          if (refreshButton != null) ...[
            const PaddingSpacer(),
            refreshButton!,
          ]
        ],
      ),
    );
  }
}

class DefaultEmptyDataWidget extends StatelessWidget {
  const DefaultEmptyDataWidget({
    Key? key,
    required this.child,
    this.button,
  }) : super(key: key);

  final Widget child;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle.merge(
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            child: child,
          ),
          if (button != null) ...[PaddingSpacer.small(), button!]
        ],
      ),
    );
  }
}
