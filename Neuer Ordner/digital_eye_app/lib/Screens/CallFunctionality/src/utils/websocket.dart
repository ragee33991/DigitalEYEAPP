import 'dart:io';

typedef void OnMessageCallback(dynamic msg);
typedef void OnCloseCallback(int code, String reason);
typedef void OnOpenCallback();

class SimpleWebSocket {
  String _url;
  var _socket;
  OnOpenCallback onOpen;
  OnMessageCallback onMessage;
  OnCloseCallback onClose;
  SimpleWebSocket(this._url);

  connect() async {
    try {
      _socket = await WebSocket.connect(_url);
      this?.onOpen();
      _socket.listen((data) {
        this?.onMessage(data);
      }, onDone: () {
        this?.onClose(_socket.closeCode, _socket.closeReason);
      });
    } catch (e) {
      this.onClose(500, e.toString());
    }
  }

  send(data) {
    if (_socket != null) {
      _socket.add(data);
      print('send: $data');
    }
  }

  close() {
    _socket.close();
  }
}
