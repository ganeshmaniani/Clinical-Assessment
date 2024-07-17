String getDiseaseNameWithSwitch(int index) {
  switch (index) {
    case 0:
      return "Eye";
    case 1:
      return "Mouth";
    case 2:
      return "Tongue";
    case 3:
      return "Gums";
    case 4:
      return "Teeth";
    case 5:
      return "Hair";
    case 6:
      return "Skin";
    case 7:
      return "Elbow";
    case 8:
      return "Nail";

    default:
      return "Unknown";
  }
}

int getCustomId(String disease) {
  switch (disease) {
    case 'Eye':
      return 1;
    case 'Mouth':
      return 2;
    case 'Tongue':
      return 3;
    case 'Gums':
      return 4;
    case 'Teeth':
      return 5;
    case 'Hair':
      return 6;
    case 'Skin':
      return 7;
    case 'Elbow':
      return 8;
    case 'Nail':
      return 9;
    default:
      return -1; // Return -1 for unknown diseases
  }
}

String getDiseaseDescription(String disease, int score) {
  switch (disease) {
    case "Eye":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Mouth":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Tongue":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Gums":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Teeth":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Hair":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Skin":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Elbow":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    case "Nail":
      if (score == 1) return "High Disease";
      if (score == 2) return "Medium Disease";
      if (score == 3) return "Low Disease";
      break;
    // Add similar logic for other diseases if required
    default:
      return "";
  }
  return "";
}
