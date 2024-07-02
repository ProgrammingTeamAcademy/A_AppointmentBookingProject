// import 'package:pusher_client/pusher_client.dart';

// class PusherService {
//   late PusherClient pusher;
//   late Channel channel;

//   PusherService() {
//     pusher = PusherClient(
//       'your-pusher-app-key',
//       PusherOptions(
//         cluster: 'your-pusher-cluster',
//         encrypted: true,
//       ),
//       autoConnect: false,
//     );

//     pusher.connect();

//     channel = pusher.subscribe('status-updates');

//     channel.bind('App\\Events\\StatusUpdatam', (event) {
//       // التعامل مع الحدث هنا
//       print(event);
//     });
//   }
// }
import 'package:booksdoctor/view/DoctorLayout/hameDoctor/hameDoctor.dart';
import 'package:get/get.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';

class PusherService {
  late PusherClient pusher;
  late Channel channel;

  PusherService() {
    PusherOptions options = const PusherOptions(
      cluster: "eu",
      encrypted: true,
    );

    pusher = PusherClient(
      "362692f95c2f979eea3a",
      options,
      autoConnect: false,
    );
  }

  void initChannel(Function(PusherEvent?) onEvent) {
    pusher.connect();

    channel = pusher.subscribe('status-updates');

    channel.bind('App\\Events\\StatusUpdata', onEvent

        // يمكنك هنا معالجة البيانات التي يتم استقبالها من Pusher
        );
  }

  void disconnect() {
    pusher.unsubscribe('status-updates');
    pusher.disconnect();
  }
}
