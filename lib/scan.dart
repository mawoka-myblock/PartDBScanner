import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanerPart extends StatefulWidget {
  final void Function(int?) onScannedCode;
  const ScanerPart({super.key, required this.onScannedCode});

  @override
  State<ScanerPart> createState() => _ScanerPartState();
}

class _ScanerPartState extends State<ScanerPart> {
  final _mobileScannerController = MobileScannerController(
    // The controller is started from the initState method.
    autoStart: true,
    detectionTimeoutMs: 500,
  );
  final _scannerEnabled = ValueNotifier(true);
  final urlExtractRegex = RegExp(r'http(?:s?):\/\/.*\/part\/(\d*)');

  void _handleBarcode(BarcodeCapture barcodes) {
    if (!mounted) return;
    final value = barcodes.barcodes.firstOrNull;
    if (value == null) {
      widget.onScannedCode(null);
      return;
    }
    final text = value.rawValue;
    if (text == null) {
      widget.onScannedCode(null);
      return;
    }
    try {
      final parsedInt = int.parse(text);
      widget.onScannedCode(parsedInt);
      return;
    } catch (_) {}
    RegExpMatch? match = urlExtractRegex.firstMatch(text);
    if (match == null) {
      widget.onScannedCode(null);
      return;
    }
    final stringId = match.group(1);
    if (stringId == null) {
      widget.onScannedCode(null);
      return;
    }
    try {
      final parsedInt = int.parse(stringId);
      widget.onScannedCode(parsedInt);
      return;
    } catch (_) {}
    widget.onScannedCode(null);
    return;
  }

  @override
  void initState() {
    super.initState();
    // Start the controller to start scanning.
    unawaited(_mobileScannerController.start());
  }

  @override
  void dispose() {
    super.dispose();
    _mobileScannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width; // Get the screen width
    final screenHeight = MediaQuery.of(context).size.height;
    final scanWindowWidth = screenWidth * 0.8; // Calculate 80% of screen width
    final scanWindowHeight = screenHeight * 0.2; // Make it a square
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => _scannerEnabled.value = false,
      onPointerUp: (_) => _scannerEnabled.value = true,
      onPointerCancel: (_) => _scannerEnabled.value = true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
            scanWindowUpdateThreshold: 5,
            scanWindow: Rect.fromCenter(
              center: MediaQuery.of(
                context,
              ).size.center(Offset.zero), // Center it
              width: scanWindowWidth,
              height: scanWindowHeight,
            ),
          ),
          Positioned.fromRect(
            rect: Rect.fromCenter(
              center: MediaQuery.of(
                context,
              ).size.center(Offset.zero), // Center it
              width: scanWindowWidth,
              height: scanWindowHeight,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: _scannerEnabled.value ? Colors.green :Colors.red , width: 2), // Red border
              ),
            ),
          ),
        ],
      ),
    );
  }
}
