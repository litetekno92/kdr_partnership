import 'dart:async';
import 'package:flutter/foundation.dart';
//import 'package:partnership/utils/FBCollections.dart';

/*
    A mixin which can be add to a ViewModel in order to let it [subscribe to / manage] a stream of users's data
*/
class StreamWrapper<T>{
  StreamController<T> _streamController;
  Future<dynamic>                 _initDone; // don't delete it, may be useful with heavy streams

  StreamWrapper(
      {
        @required Stream<T>    stream,
        @required Function     listenCallback,
        @required Function     pauseCallback,
        @required Function     resumeCallback,
        @required Function     cancelCallback,
        Function               errorCallback
      })
  {
    try{
      assert(listenCallback != null);
      assert(pauseCallback != null);
      assert(resumeCallback != null);
      assert(cancelCallback != null);
      this._streamController = StreamController<T>
        (
          onListen: listenCallback,
          onPause: pauseCallback,
          onResume: resumeCallback,
          onCancel: cancelCallback
        );
      _initDone = this._addStream(stream)
                      .then((_) => this._streamController.sink.close());
    }
    catch(error){
      if (errorCallback != null)
        errorCallback(error);
      else
        print(error);
    }
  }

  Future<dynamic> _addStream(Stream<T> stream) async {
    return await this._streamController.addStream(stream);
  }

/* Don't know if necessary, don't delete until tested with really heavy stream.
  Future<dynamic> get initDone => this._initDone;
  Future<dynamic> awaitWrapperReady() async{
    return await this.initDone;
  }
*/

  Stream<T> getStream(){
    return this._streamController.stream;
  }

  StreamSubscription<T> subscribeToStream({@required Function handler}){
    try{
      assert(handler != null, "A handler must be provided");
      return this.getStream().listen(handler);
    }
    catch (_){
      return null;
    }
  }
}
