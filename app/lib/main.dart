import 'dart:ffi';

import 'package:app/const.dart';
import 'package:app/page/eyeball.dart';
import 'package:app/rustlib/rteyelib.dart';
import 'package:app/services/ffi_service.dart';
import 'package:app/utils/config.dart';
import 'package:app/ffikit/ffi_loader.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    // size: Size(25, 100),
    // maximumSize: Size(50, 100),
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );


  // await initFfiLibs();
  // print('natives: ${FfiProxy().natives}');
  // var rteyeNative = FfiProxy().getLib<RteyeLibNativeLibrary>(FfiLibTag.rteye.name);
  // final ffiData = rteyeNative.get_net_stat();
  // var e = ffiData.cast<Array<Pointer>>();
  // print("rteyeNative: ${e}}");

  // var dl = DynamicLibrary.open("libexample.so");
  // var native = NativeLibrary(dl);
  //
  // String p = "/";
  // var ffiData = native.list_dir_contents(
  //     convertFfiOrDart<StringToPointChar, String, Pointer<Char>>(StringToPointChar(), p)
  // );
  // String pathInfo = convertFfiOrDart<PointCharToString, Pointer<Char>, String>(
  //     PointCharToString(), ffiData);
  // print("$pathInfo");


  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //
  //   await windowManager.show();
  //   await windowManager.focus();
  //   await windowManager.setAsFrameless();
  //   await windowManager.undock();
  //
  //
  // });
  //
  // runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    sharedConfigManager.addListener(configListen);
    super.initState();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(configListen);
    super.dispose();
  }

  void configListen() {
    themeMode = sharedConfig.themeMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final botToastBuilder = BotToastInit();

    // return EyeballPage();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      builder: (context, child) {
        child = virtualWindowFrameBuilder(context, child);
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const EyeballPage(),
    );
  }
}



// class MyApp1 extends StatelessWidget {
//   const MyApp1({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
