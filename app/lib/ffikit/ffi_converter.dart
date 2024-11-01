import 'dart:ffi';

import 'package:ffi/ffi.dart';

abstract class FfiTypeConverter<I, O> {
  O convert(I value);
}

class PointerCharToString extends FfiTypeConverter<Pointer<Char>, String> {

  @override
  String convert(Pointer<Char> value) {
    return value.cast<Utf8>().toDartString();
  }
}

class StringToPointerChar extends FfiTypeConverter<String, Pointer<Char>>{
  @override
  Pointer<Char> convert(String value){
    return value.toNativeUtf8().cast();
  }
}

// class PointerPointerToList extends FfiTypeConverter<Pointer<Pointer>, List<dynamic>>{
//   @override
//   List<dynamic> convert(Pointer<Pointer> value){
//     return value;
//   }
// }