

class GameStrings {
  String playCap = "PLAY";
  String creditsCap = "CREDITS";
  String poweredBy = "Powered by ";
  String builtWith = "Built with ";
  String talkWizard1 = "Hello my young knight!\nWhat are you doing here?";
  String talkPlayer1 = "Hello!\nI was sent to rescue a child who was kidnapped by creatures that live in those neighborhoods.";
  String talkWizard2 = "Humm...\nI don't want to demotivate you, but you are the fifth knight sent for this task. So far, none have returned alive and their bodies are hanging from the walls like trophies.";
  String talkPlayer2 = "Don't worry my old man. Knight like me never existed!\nI will exterminate every creature in this place and rescue the child!";
  String talkWizard3 = "Yes, confidence is what you don't lack!\nThen don't say I didn't warn you!\nGood luck!";
  String talkKid1 = "Heeeelp! Heeeelp!";
  String talkBoss1 = "Shut up, you appetizing little creature!\nThe time has come to taste your soft skin! ha ha ha ha";
  String talkPlayer3 = "It won't be your disgusting creature this time!\nYour monstrous days are over!";
  String talkBoss2 = "Look that! Another knight with an inflated ego thinking he can stop me! ha ha ha ha \nCome here!";
  String talkKid2 = "Thank the gods !!! \nYou managed to defeat this horrible creature! Thank you very much! \nI don't even know how to thank you!";
  String talkPlayer4 = "It was an honor to be able to help you! And don't worry about rewarding me, your father promised me a fortune to rescue you! :-)";
  String playAgainCap = "PLAY AGAIN";
  String congratulations = "CONGRATULATIONS!";
  String thanks = "Thanks for testing the game and feeling the power of Flame and Bonfire in building 2D games.\nMaybe we can have a continuation of the game!\nI hope that you enjoyed!";
  String doorWithoutKey = "I think I need a key to get through here!";
  
}

   String getString(String key) {
    switch (key) {
      case 'play_cap':
        return GameStrings().playCap;
      case 'credits_cap':
        return GameStrings().creditsCap;
      case 'powered_by':
        return GameStrings().poweredBy;
      case 'built_with':
        return GameStrings().builtWith;
      case 'talk_wizard_1':
        return GameStrings().talkWizard1;
      case 'talk_player_1':
        return GameStrings().talkPlayer1;
      case 'talk_wizard_2':
        return GameStrings().talkWizard2;
      case 'talk_player_2':
        return GameStrings().talkPlayer2;
      case 'talk_wizard_3':
        return GameStrings().talkWizard3;
      case 'talk_kid_1':
        return GameStrings().talkKid1;
      case 'talk_boss_1':
        return GameStrings().talkBoss1;
      case 'talk_player_3':
        return GameStrings().talkPlayer3;
      case 'talk_boss_2':
        return GameStrings().talkBoss2;
      case 'talk_kid_2':
        return GameStrings().talkKid2;
      case 'talk_player_4':
        return GameStrings().talkPlayer4;
      case 'play_again_cap':
        return GameStrings().playAgainCap;
      case 'congratulations':
        return GameStrings().congratulations;
      case 'thanks':
        return GameStrings().thanks;
      case 'door_without_key':
        return GameStrings().doorWithoutKey;
      default:
        return ''; // Return an empty string if the key is not found
    }
  }