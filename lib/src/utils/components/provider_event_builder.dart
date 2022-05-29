import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


class ProviderEventBuilder<T, K> extends ConsumerStatefulWidget {
  const ProviderEventBuilder({
    Key? key,
    required this.provider,
    required this.event,
    required this.onEvent,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final ProviderEvent<K> event;
  final ProviderListenable<T> provider;
  final Function(K event) onEvent;

  @override
  ConsumerState<ProviderEventBuilder<T, K>> createState() => _ProviderEventBuilderState<T, K>();
}


class _ProviderEventBuilderState<T, K> extends ConsumerState<ProviderEventBuilder<T, K>> {
  _handle() {
    final value = widget.event.consume(originator: context.owner);
    if (value != null) {
      widget.onEvent(value);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handle();
    }); 
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<T>(widget.provider, (_, notifier) {
      _handle();
    });
    return widget.child;
  }
}