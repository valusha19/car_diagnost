 import 'package:firebase_core/firebase_core.dart';
import 'package:car_diagnost/firebase_options.dart'; // Додай цей імпорт



class FirebaseService {
  static Future<void> init() async {
   await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );
}
}