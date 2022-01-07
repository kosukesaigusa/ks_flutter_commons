import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Firebase Emulator Suite に接続するための設定を行う。
Future<void> setUpLocalEmulator({
  String localhost = 'localhost',
  int firestorePortNumber = 8080,
  int functionsPortNumber = 5001,
  int authPortNumber = 9099,
  int storagePortNumber = 9199,
  String backet = 'default-bucket',
  bool firestoreSSLEnabled = false,
  bool firestorePersistenceEnabled = true,
}) async {
  print('-------------------------------------------');
  print('Running with Firebase Local Emulator Suite');
  print('-------------------------------------------');
  FirebaseFirestore.instance.settings = Settings(
    host: '$localhost:$firestorePortNumber',
    sslEnabled: firestoreSSLEnabled,
    persistenceEnabled: firestorePersistenceEnabled,
  );
  FirebaseFirestore.instance.useFirestoreEmulator(localhost, firestorePortNumber);
  FirebaseFunctions.instance.useFunctionsEmulator(localhost, functionsPortNumber);
  FirebaseStorage.instanceFor(bucket: backet);
  await Future.wait(
    [
      FirebaseAuth.instance.useAuthEmulator(localhost, authPortNumber),
      FirebaseStorage.instance.useStorageEmulator(localhost, storagePortNumber),
    ],
  );
}
