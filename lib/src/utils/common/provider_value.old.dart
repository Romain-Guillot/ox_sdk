import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';

@Deprecated('Use ProviderValue')
class DeprecatedProviderValue<T, K> {
  DeprecatedProviderValue({
    this.notify,
  });

  DeprecatedProviderValue.fromValue(
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
@Deprecated('Use ProviderValue')
class DeprecatedProviderValueBuilder<T, K> extends StatelessWidget {
  const DeprecatedProviderValueBuilder({
    Key? key,
    required this.value,
    required this.dataBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.emptyDataBuilder,
    this.isSliver = false,
    this.refreshButton,
  }) : super(key: key);

  final DeprecatedProviderValue<T, K> value;

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
      return dataBuilder(context, value.value as T);
    }
    if (isSliver) {
      child = SliverToBoxAdapter(child: child);
    }
    return child;
  }
}

@Deprecated('Use ProviderValue')
class DeprecatedDefaultErrorWidget extends StatelessWidget {
  const DeprecatedDefaultErrorWidget({
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

@Deprecated('Use ProviderValue')
class DeprecatedDefaultEmptyDataWidget extends StatelessWidget {
  const DeprecatedDefaultEmptyDataWidget({
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
