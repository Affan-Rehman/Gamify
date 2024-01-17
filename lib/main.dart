import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamify/spacescape/lib/main.dart';
import 'package:gamify/spacescape/lib/models/spaceship_details.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:gamify/spacescape/lib/models/player_data.dart';
import 'MyApp/gamescreen.dart';
import 'MyApp/loginscreen.dart';
import 'firebase_options.dart';

late Size screenSizeActual;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(PlayerDataAdapter());
  Hive.registerAdapter(SpaceshipTypeAdapter());
  runApp(MultiProvider(
    providers: [
      FutureProvider<PlayerData>(
        create: (BuildContext context) => getPlayerData(),
        initialData: PlayerData.fromMap(PlayerData.defaultData),
      ),
    ],
    builder: (context, child) {
      // We use .value constructor here because the required objects
      // are already created by upstream FutureProviders.
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<PlayerData>.value(
            value: Provider.of<PlayerData>(context),
          ),
        ],
        child: child,
      );
    },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use custom theme with 'BungeeInline' font.
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'BungeeInline',
        scaffoldBackgroundColor: Colors.black,
      ),
      // home: FirebaseAuth.instance.currentUser == null
      home: GameScreen(),
      // ? const LoginScreen()
      // : GameScreen(),
    ),
  ));
}
