import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';

class ProviderValue<T, K> {
  ProviderValue({
    this.notify,
  });

  ProviderValue.fromValue(
    T value, {
    this.notify,
  }) {
    this.value = value;
  }

  final Function? notify;

  T? _value;
  set value(T? value) {
    _value = value;
    _initialized = true;
    _error = null;
    notify?.call();
  }

  T? get value => _value;
  bool get hasData {
    if (value is Iterable) {
      return value != null && (value as Iterable<dynamic>).isNotEmpty;
    } else {
      return value != null;
    }
  }

  K? _error;
  set error(K? error) {
    _error = error;
    _initialized = true;
    _value = null;
    notify?.call();
  }

  K? get error => _error;
  bool get hasError => _error != null;

  bool? _initialized;
  bool get isInitialized => _initialized == true;
  bool get isNotInitialized => !isInitialized;

  void reset() {
    _error = null;
    _value = null;
    _initialized = false;
    notify?.call();
  }
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
    Widget child;
    if (value.hasError) {
      child = errorBuilder != null
          ? errorBuilder!(context, value.error)
          : DefaultErrorWidget(
              refreshButton: refreshButton,
              error: value.error.toString(),
            );
    } else if (!value.isInitialized) {
      child = loadingBuilder != null ? loadingBuilder!(context) : const OLoadingIndicator();
    } else if (emptyDataBuilder != null && !value.hasData) {
      child = emptyDataBuilder!.call(context);
    } else {
      return dataBuilder(context, value.value!);
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            child: child,
          ),
          if (button != null) ...[PaddingSpacer.small(), button!]
        ],
      ),
    );
  }
}
