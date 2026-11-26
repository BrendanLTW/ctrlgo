// The web build loads the Maps JS API itself; mobile reads its key natively.
export 'maps_loader_stub.dart'
    if (dart.library.js_interop) 'maps_loader_web.dart';
