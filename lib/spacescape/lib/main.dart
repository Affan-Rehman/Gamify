import 'package:hive_flutter/hive_flutter.dart';
import 'models/player_data.dart';

// This function initializes hive with app's
// documents directory and also registers
// all the hive adapters.

/// This function reads the stored [PlayerData] from disk.
Future<PlayerData> getPlayerData() async {
  
  // Open the player data box and read player data from it.
  final box = await Hive.openBox<PlayerData>(PlayerData.playerDataBox);
  final playerData = box.get(PlayerData.playerDataKey);

  // If player data is null, it means this is a fresh launch
  // of the game. In such case, we first store the default
  // player data in the player data box and then return the same.
  if (playerData == null) {
    box.put(
      PlayerData.playerDataKey,
      PlayerData.fromMap(PlayerData.defaultData),
    );
  }

  return box.get(PlayerData.playerDataKey)!;
}

/// This function reads the stored [Settings] from disk.

