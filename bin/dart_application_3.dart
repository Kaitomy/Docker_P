import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_application_3/dart_application_3.dart';

void main() async {
  final port = int.parse(Platform.environment["PORT"] ?? '8889');

  final service = Application<AppService>()
    ..options.port = port
    ..options.certificateFilePath = 'config.yaml';
  await service.start(numberOfInstances: 3, consoleLogging: true);
}
