import 'package:app/ffikit/ffi_loader.dart';

enum FfiLibTag {
  rteye,
}

Map<String, FfiLib> ffiLibs = {
  FfiLibTag.rteye.name: FfiLib(libPath: "assets/dls/rteye.dll"),
};
