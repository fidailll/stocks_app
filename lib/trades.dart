import 'package:web_socket_channel/web_socket_channel.dart';

class Trades {
  String url = 'wss://ws.finnhub.io/?token=c8sugoiad3ib2st12aa0';

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.finnhub.io/?token=c8sugoiad3ib2st12aa0'),
  );
}
