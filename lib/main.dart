import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partdb_scanner/api/models/category_read.dart';
import 'package:partdb_scanner/api/models/part_read.dart';
import 'package:partdb_scanner/api/models/partlot_read.dart';
import 'package:partdb_scanner/scan.dart';
import 'package:partdb_scanner/setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartDB Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class Preferences {
  late String url;
  late String token;

  Preferences(this.url, this.token);

  Preferences.fromSharedPreferences(SharedPreferences prefs) {
    final url = prefs.getString("partdb_url");
    final token = prefs.getString("partdb_token");
    if (url == null || token == null) {
      throw "Preferences not Initialized!";
    }
    this.url = url;
    this.token = token;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  /// Load the initial counter value from persistent storage on start,
  /// or fallback to 0 if it doesn't exist.
  Future<Preferences> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return Preferences.fromSharedPreferences(prefs);
  }

  Future<void> _markSetupComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setup_complete', true);
    setState(() {}); // Refresh the FutureBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _loadUserData(),
        builder: (ctx, AsyncSnapshot<Preferences> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return MainScreen(prefs: snapshot.data!);
            } else {
              return SetupScreen(onSetupComplete: _markSetupComplete);
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have pushed the button this many times: '),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Preferences prefs;
  const MainScreen({super.key, required this.prefs});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? scannedId;
  bool scannerActive = true;

  void _setScannedId(int? id) {
    HapticFeedback.vibrate();
    if (id == null) return;
    setState(() {
      scannedId = id;
    });
  }

  void setScannerActivity(bool activity) {
    setState(() {
      scannerActive = activity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        scannerActive
            ? ScanerPart(onScannedCode: _setScannedId)
            : SizedBox.expand(),
        Align(
          alignment: Alignment.bottomCenter,
          child:
              scannedId == null
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff6f6f6),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      alignment: Alignment.bottomCenter,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "Start scanning a code!",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : PartQuickActions(
                    partId: scannedId!,
                    prefs: widget.prefs,
                    setScannerActivity: setScannerActivity,
                  ),
        ),
      ],
    );
  }
}

class PartQuickActions extends StatefulWidget {
  final int partId;
  final Preferences prefs;
  final void Function(bool) setScannerActivity;
  const PartQuickActions({
    super.key,
    required this.partId,
    required this.prefs,
    required this.setScannerActivity,
  });

  @override
  State<PartQuickActions> createState() => _PartQuickActionsState();
}

class _PartQuickActionsState extends State<PartQuickActions> {
  bool _isLoading = false;
  bool _is80Percent = false;
  late Future<PartRead?> _partFuture;
  Future<PartRead?> getPart() async {
    developer.log("Future loading");
    return await PartRead.get(widget.partId, widget.prefs);
  }

  @override
  void initState() {
    _partFuture = getPart(); // Initialize _partFuture here
    super.initState();
  }

  @override
  void didUpdateWidget(PartQuickActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.partId != oldWidget.partId) {
      _partFuture = getPart(); // Re-fetch data when partId changes
    }
  }

  void changeAmount(int amount, int partLotId) {
    setState(() {
      _isLoading = true;
    });
    developer.log("Changed amount");
    final changedData = PartlotUpdate(amount: amount);
    changedData
        .save(partLotId, widget.prefs)
        .then(
          (_) => setState(() {
            _isLoading = false;
            _partFuture = getPart();
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.31,
      initialChildSize: 0.31,
      snapSizes: [0.31, 0.83, 1],
      snap: true,
      builder: (ctx, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (ltctx, constraints) {
              final screenHeight = MediaQuery.of(context).size.height;
              final eightyPercentHeight = screenHeight * 0.8;
              return NotificationListener(
                onNotification: (not) {
                  if (not is ScrollEndNotification) {
                    if (constraints.maxHeight >= eightyPercentHeight &&
                        !_is80Percent) {
                      widget.setScannerActivity(false);
                      _is80Percent = true;
                    } else if (constraints.maxHeight < eightyPercentHeight &&
                        _is80Percent) {
                      widget.setScannerActivity(true);
                      _is80Percent = false;
                    }
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: _partFuture,
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData && !_isLoading) {
                              return Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "#${snapshot.data!.id}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data!.name,
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  Center(
                                    child: PartCategory(
                                      prefs: widget.prefs,
                                      categoryPath:
                                          snapshot.data!.category!.typeId,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data!.totalInstock == null
                                          ? "Unknown Stock"
                                          : "Currently in stock: ${snapshot.data!.totalInstock!}",
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  InputModifiers(
                                    changeAmount: changeAmount,
                                    currentlyInStock:
                                        snapshot.data!.totalInstock!,
                                    partLotId: snapshot.data!.partLots![0].id,
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data!.manufacturer!.name,
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data!.description!,
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  snapshot
                                              .data
                                              ?.masterPictureAttachment
                                              ?.mediaUrl !=
                                          null
                                      ? Image.network(
                                        snapshot
                                            .data!
                                            .masterPictureAttachment!
                                            .mediaUrl!,
                                      )
                                      : SizedBox.shrink(),
                                  PartParameterDisplay(part: snapshot.data!),
                                ],
                              );
                            } else if (snapshot.hasError && !_isLoading) {
                              return Text("Error! ${snapshot.error}");
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: LinearProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class InputModifiers extends StatefulWidget {
  final void Function(int, int) changeAmount;
  final int currentlyInStock;
  final int partLotId;
  const InputModifiers({
    super.key,
    required this.changeAmount,
    required this.currentlyInStock,
    required this.partLotId,
  });

  @override
  State<InputModifiers> createState() => _InputModifiersState();
}

class _InputModifiersState extends State<InputModifiers> {
  final _amountInputKey = TextEditingController();
  bool _canRemove = true;

  void changeCustomAmount(bool add) {
    final inputVal = int.parse(_amountInputKey.text);
    add
        ? widget.changeAmount(
          widget.currentlyInStock + inputVal,
          widget.partLotId,
        )
        : widget.changeAmount(
          widget.currentlyInStock - inputVal,
          widget.partLotId,
        );
  }

  @override
  void dispose() {
    _amountInputKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FilledButton(
              onPressed:
                  widget.currentlyInStock - 1 < 0
                      ? null
                      : () => widget.changeAmount(
                        widget.currentlyInStock - 1,
                        widget.partLotId,
                      ),
              child: Text("-1"),
            ),
            FilledButton(
              onPressed:
                  widget.currentlyInStock - 2 < 0
                      ? null
                      : () => widget.changeAmount(
                        widget.currentlyInStock - 2,
                        widget.partLotId,
                      ),
              child: Text("-2"),
            ),
            FilledButton(
              onPressed:
                  widget.currentlyInStock - 3 < 0
                      ? null
                      : () => widget.changeAmount(
                        widget.currentlyInStock - 3,
                        widget.partLotId,
                      ),
              child: Text("-3"),
            ),
            FilledButton(
              onPressed:
                  widget.currentlyInStock - 5 < 0
                      ? null
                      : () => widget.changeAmount(
                        widget.currentlyInStock - 5,
                        widget.partLotId,
                      ),
              child: Text("-5"),
            ),
            FilledButton(
              onPressed:
                  widget.currentlyInStock - 10 < 0
                      ? null
                      : () => widget.changeAmount(
                        widget.currentlyInStock - 10,
                        widget.partLotId,
                      ),
              child: Text("-10"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 10,
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _canRemove ? () => changeCustomAmount(false) : null,
                child: Text("Remove"),
              ),
            ),

            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter amount",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _amountInputKey,
                onChanged: (value) {
                  final parsedInt = int.tryParse(value);
                  if (parsedInt == null) return;
                  setState(() {
                    _canRemove =
                        widget.currentlyInStock - parsedInt < 0 ? false : true;
                  });
                },
              ),
            ),
            Expanded(
              child: FilledButton(
                onPressed: () => changeCustomAmount(true),
                child: Text("Add"),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FilledButton(
              onPressed:
                  () => widget.changeAmount(
                    widget.currentlyInStock + 1,
                    widget.partLotId,
                  ),
              child: Text("+1"),
            ),
            FilledButton(
              onPressed:
                  () => widget.changeAmount(
                    widget.currentlyInStock + 2,
                    widget.partLotId,
                  ),
              child: Text("+2"),
            ),
            FilledButton(
              onPressed:
                  () => widget.changeAmount(
                    widget.currentlyInStock + 3,
                    widget.partLotId,
                  ),
              child: Text("+3"),
            ),
            FilledButton(
              onPressed:
                  () => widget.changeAmount(
                    widget.currentlyInStock + 5,
                    widget.partLotId,
                  ),
              child: Text("+5"),
            ),
            FilledButton(
              onPressed:
                  () => widget.changeAmount(
                    widget.currentlyInStock + 10,
                    widget.partLotId,
                  ),
              child: Text("+10"),
            ),
          ],
        ),
      ],
    );
  }
}

class PartCategory extends StatefulWidget {
  final Preferences prefs;
  final String categoryPath;
  const PartCategory({
    super.key,
    required this.prefs,
    required this.categoryPath,
  });

  @override
  State<PartCategory> createState() => _PartCategoryState();
}

class _PartCategoryState extends State<PartCategory> {
  Future<CategoryRead?> getCategory() async {
    final catId = CategoryRead.extractIdFromPath(widget.categoryPath);
    developer.log(catId.toString());
    if (catId == null) return null;
    return await CategoryRead.get(catId, widget.prefs);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: FutureBuilder(
        future: getCategory(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return SizedBox.shrink();
            } else {
              return Text(snapshot.data!.fullPath);
            }
          } else if (snapshot.hasError) {
            return Text(
              "Failed to fetch category",
              style: TextStyle(color: Colors.red),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [LinearProgressIndicator()],
            );
          }
        },
      ),
    );
  }
}

class PartParameterDisplay extends StatelessWidget {
  final PartRead part;
  const PartParameterDisplay({super.key, required this.part});
  final _tableHeadingTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Text("Parameters", style: _tableHeadingTextStyle),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Text("Symbol", style: _tableHeadingTextStyle),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Text("Value", style: _tableHeadingTextStyle),
              ),
            ),
          ],
        ),
        for (final param in part.parameters!)
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(param.name),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(param.symbol ?? ""),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(param.formatted),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
