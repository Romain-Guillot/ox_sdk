import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:ox_sdk/src/odesign/grid.dart';
import 'package:ox_sdk/src/odesign/snackbar.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/common/logger.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';
import 'package:ox_sdk/src/utils/developper_info/device_info.service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class DevelopperInfoPage extends StatefulWidget {
  const DevelopperInfoPage({Key? key, this.appBar = true}) : super(key: key);

  final bool appBar;

  @override
  DevelopperInfoPageState createState() => DevelopperInfoPageState();
}

class DevelopperInfoPageState extends State<DevelopperInfoPage> {
  DeviceInfo? info;
  List<LogEntry>? logs;
  bool isInitialized = false;

  String generateAssistanceContent() {
    return "${DateTime.now().toIso8601String()}\n#INFO\n${info?.toString() ?? 'No info'}\n#LOGS\n${logs?.map((e) => '${e.emitter}-${e.level.name}-${e.message}-${e.exception}-${e.stacktrace}').join('\n') ?? 'no log'}";
  }

  String generateAssistanceTitle() {
    return 'logs_${DateTime.now().toIso8601String()}';
  }

  Future<void> onShare() async {
    Share.share(generateAssistanceContent(), subject: generateAssistanceTitle());
  }

  Future<void> onDownload() async {
    var status = await Permission.storage.status;
    if (status.isGranted == false) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      final directory = await getExternalStorageDirectories(type: StorageDirectory.downloads);
      print('${directory?.first.path ?? '/storage/emulated/0/Download'}/${generateAssistanceTitle()}.txt');
      final file = File('${directory?.first.path ?? '/storage/emulated/0/Download'}/${generateAssistanceTitle()}.txt');
      await file.writeAsString(generateAssistanceContent());
    } else if (mounted) {
      showErrorSnackbar(
        context: context,
        content: Text('Permission not granted'),
      );
    }
  }

  Future<void> retrieveInfo() async {
    try {
      logs = XLogger.lastEntries.toList();
    } catch (e) {
      // TODO(romain):
    }
    info = await DeviceInfoService().retrieve();
    setState(() => isInitialized = true);
  }

  @override
  void initState() {
    super.initState();
    retrieveInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (isInitialized == false) {
      return const Center(child: CircularProgressIndicator());
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: !widget.appBar
            ? null
            : AppBar(
                title: const Text('Assistance'),
                actions: [
                  IconButton(
                    onPressed: () => onDownload(),
                    icon: const Icon(Icons.download),
                  ),
                  IconButton(
                    onPressed: () => onShare(),
                    icon: const Icon(Icons.share_outlined),
                  )
                ],
              ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.perm_device_information_outlined),
                  child: Text('Device info'),
                ),
                Tab(
                  icon: Icon(Icons.bug_report_outlined),
                  child: Text('Logs'),
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: <Widget>[
                DeviceInfoWidget(
                  info: info,
                ),
                LogsWidget(
                  logs: logs,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceInfoWidget extends StatelessWidget {
  const DeviceInfoWidget({Key? key, required this.info}) : super(key: key);

  final DeviceInfo? info;

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return Center(child: Text('Not available'));
    } else {
      return ODataGrid<DeviceInfoItem>(
        columns: [
          OGridColumn(
            key: const Key('info'),
            weight: 1,
            label: 'Info',
            renderer: (index, info) => Text(info.label),
          ),
          OGridColumn(
            key: const Key('Value'),
            weight: 2,
            label: 'Value',
            renderer: (index, info) => Text(
              info.value ?? 'Unknown',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
        values: info?.items ?? [],
      );
    }
  }
}

class LogsWidget extends StatelessWidget {
  const LogsWidget({Key? key, required this.logs}) : super(key: key);

  final List<LogEntry>? logs;

  @override
  Widget build(BuildContext context) {
    if (logs == null) {
      return const Center(child: Text('No logs'));
    } else {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 2000,
            child: ListView.separated(
              itemCount: logs!.length,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
              itemBuilder: (context, index) {
                final log = logs!.elementAt(index);
                return LogItemWidget(log: log);
              },
            ),
          ));
    }
  }
}

class LogItemWidget extends StatelessWidget {
  const LogItemWidget({Key? key, required this.log}) : super(key: key);

  final LogEntry log;

  @override
  Widget build(BuildContext context) {
    Map<Level, Color> levelColors = {
      Level.verbose: Theme.of(context).colors.info,
      Level.debug: Theme.of(context).colors.info,
      Level.info: Theme.of(context).colors.info,
      Level.warning: Theme.of(context).colors.warning,
      Level.error: Theme.of(context).colors.error,
      Level.wtf: Theme.of(context).colorScheme.onTertiaryContainer,
    };
    final color = levelColors[log.level]!;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => LogDetailDialog(
                      log: log,
                    ));
          },
          child: Padding(
            padding: EdgeInsets.all(Theme.of(context).paddings.small),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  radius: 7,
                ),
                const PaddingSpacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(log.emitter, style: Theme.of(context).textTheme.bodySmall),
                    Text(log.message?.toString() ?? 'No message'),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class LogDetailDialog extends StatelessWidget {
  const LogDetailDialog({Key? key, required this.log}) : super(key: key);

  final LogEntry log;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const Expanded(child: Text('Détail')),
          IconButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                  text: (log.message?.toString() ?? 'No message') +
                      (log.exception?.toString() ?? 'No exception') +
                      (log.stacktrace?.toString() ?? 'No stacktrace'),
                ),
              );
              showSuccessSnackbar(
                context: context,
                content: const Text('Copied'),
              );
            },
            icon: const Icon(Icons.file_copy_outlined),
          )
        ],
      ),
      scrollable: true,
      content: SingleChildScrollView(
        child: DefaultTextStyle.merge(
          style: const TextStyle(fontFamily: 'UbuntuMono', package: 'fl_sms_ui', fontWeight: FontWeight.normal, fontSize: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(log.message?.toString() ?? 'No message'),
              Divider(height: Theme.of(context).paddings.medium),
              Text(log.exception?.toString() ?? 'No exception'),
              Divider(height: Theme.of(context).paddings.medium),
              Text(log.stacktrace?.toString() ?? 'No stacktrace')
            ],
          ),
        ),
      ),
    );
  }
}
