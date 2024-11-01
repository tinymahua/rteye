import 'package:app/const.dart';
import 'package:app/rustlib/rteyelib.dart';
import 'package:app/ffikit/ffi_loader.dart';

initFfiLibs()async{
  for (var e in ffiLibs.entries){
    await FfiProxy().proxyLib(
        e.key,
        RteyeLibNativeLibrary(await FfiProxy().platformFfiLoader.prepareLib(e.value)));
  }

  ffiLibs.forEach((tag, ffiLib)async{

  });
}