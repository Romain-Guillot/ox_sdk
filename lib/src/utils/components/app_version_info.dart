import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Composant pour afficher la version de l'application
///
/// Uniquement disponible pour Android et iOS
///
/// [notAvailableChild] permet de spécifier le widget à afficher sur les plateformes non supportées
///     (par defaut, un [Container] vide)
///
/// [loadingChild] permet de spécifier le widget à afficher lors du chargement des infos
///     (par defaut, un [Container] vide)
class OAppVersionInfoWidget extends StatefulWidget {
  const OAppVersionInfoWidget({super.key});

  @override
  OAppVersionInfoWidgetState createState() => OAppVersionInfoWidgetState();
}

class OAppVersionInfoWidgetState extends State<OAppVersionInfoWidget> {
  late ConfettiController confettiController;

  String? _version;
  String? get version => _version;
  set version(String? value) {
    setState(() => _version = value);
  }

  String? _buildNumber;
  String? get buildNumber => _buildNumber;
  set buildNumber(String? value) {
    setState(() => _buildNumber = value);
  }

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    setState(() => _counter = value);
  }

  @override
  void initState() {
    super.initState();
    loadAppInfo();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  Future<void> loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        ConfettiWidget(
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 75,
          confettiController: confettiController,
        ),
        GestureDetector(
          onTap: () {
            counter++;
            if (counter >= 5) {
              confettiController.play();
              counter = 0;
            }
          },
          child: version == null
              ? const SizedBox.shrink()
              : Text(
                  '$version • $buildNumber',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
        )
      ],
    );
  }
}
