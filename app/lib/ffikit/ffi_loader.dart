import 'dart:ffi';
import 'dart:io';

import 'package:app/rustlib/rteyelib.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider_windows/path_provider_windows.dart';


class FfiLib{
  String libPath;

  FfiLib({required this.libPath});
}


abstract class PlatformFfiLoader{
  prepareLib(FfiLib ffiLib)async{}
}

class FfiWinLoader implements PlatformFfiLoader{
  FfiWinLoader._internal();

  factory FfiWinLoader() => _instance;

  static final FfiWinLoader _instance = FfiWinLoader._internal();

  final PathProviderWindows provider = PathProviderWindows();

  @override
  Future<DynamicLibrary> prepareLib(FfiLib ffiLib)async{
    final appDocDir = await provider.getApplicationDocumentsPath();
    var libBundle = await rootBundle.load(ffiLib.libPath);

    var ffiLibFileName = p.basename(ffiLib.libPath);
    var libPath = join(appDocDir!, ffiLibFileName);

    final libFile = File(libPath);
    if (!libFile.existsSync()) {
      await libFile.create(recursive: true);
    }
    await libFile.writeAsBytes(libBundle.buffer.asUint8List());

    DynamicLibrary dl = DynamicLibrary.open(libPath);
    return dl;
  }


}

class FfiProxy {

  Map<String, dynamic> natives = {};

  FfiProxy._internal();

  factory FfiProxy() => _instance;

  static final FfiProxy _instance = FfiProxy._internal();

  PlatformFfiLoader get platformFfiLoader{
    if (Platform.isWindows){
      return FfiWinLoader();
    }else{
      throw Exception('Not implemented for os ${Platform.operatingSystem}');
    }
  }

  proxyLib<N>(String tag, N native)async{
    natives[tag] = native;
  }

  N getLib<N>(String tag){
    var native = natives[tag];
    return native as N;
  }
}
