import java.util.Random;

Random rand;
String currentLetter;
int lastUpdate = 0;

// Listes de mots
String[] first = {"Coucou", "Salut", "Yo", "Hey"};
String[] second = {"Agathe", "Raph", "Yanis", "Alina", "Marine", "Julien", "Romane", "Chloé", "Nils", "Roméo", "Matthieu"};
String[] adjectives = {
  "méchant",
  "froid",
  "indifférent",
  "anxieux",
  "ardent",
  "avide",
  "essoufflé",
  "brûlant",
  "jaloux",
  "envieux",
  "curieux",
  "désagréable",
  "cher",
  "dévoué",
  "impatient",
  "érotique",
  "fervent",
  "attaché",
  "impatient",
  "obsessif",
  "petit",
  "haïssable",
  "malsain",
  "égoïste",
  "passionné",
  "précieux",
  "amer",
  "indifférent",
  "insatisfait",
  "nostalgique",
};
String[] nouns = {
  "haine",
  "indifférence",
  "ambition malsaine",
  "appétit vorace",
  "ardeur destructrice",
  "laideur",
  "désir malsain",
  "obsession",
  "impatience",
  "désenchantement",
  "fanatisme",
  "caprice",
  "égocentrisme",
  "intolérance",
  "aversion",
  "cœur froid",
  "faim insatiable",
  "infatuation",
  "désintérêt",
  "désir frustré",
  "amour toxique",
  "luxure",
  "passion destructrice",
  "ravissement cruel",
  "mépris",
  "dureté",
  "soif de pouvoir",
  "voeu impossible",
  "désir ardent",
};
String[] adverbs = {
  "méchamment",
  "anxieusement",
  "ardemment",
  "avidement",
  "laidement",
  "haletant",
  "brûlant",
  "jalousement",
  "curieusement",
  "obsessivement",
  "impatientement",
  "fanatiquement",
  "amèrement",
  "impatiemment",
  "âprement",
  "égoïstement",
  "passionnément",
  "séducteur",
  "durement",
  "victorieusement",
  "nostalgiquement",
};
String[] verbs = {
  "haït",
  "attire négativement",
  "s’occupe mal de",
  "méprise",
  "s’accroche à",
  "désire malsainement",
  "tient à mal",
  "espère vainement",
  "faim de pouvoir",
  "est obsédé par",
  "aime peu",
  "désire frustré",
  "toxique pour",
  "lustre malsain",
  "cherche à manipuler",
  "s’obsède sur",
  "prend trop à cœur",
  "souffre de",
  "tente de tromper",
  "soif destructrice",
  "préfère égoïstement",
  "veut posséder",
  "souhaite mal",
  "flirte pour nuire",
  "désire excessivement",
};

void setup() {
  size(800, 600);
  rand = new Random();
  textFont(createFont("Arial", 16));
  textAlign(LEFT, TOP);
  fill(0); // noir pour le texte
  currentLetter = letter(); // poème initial
}

void draw() {
  background(255); // blanc
  text(currentLetter, 40, 40, width - 80, height - 80);

  if (millis() - lastUpdate > 12000) {
    currentLetter = letter(); // nouveau poème
    lastUpdate = millis();
  }
}

//Ajouter un mot aléatoire à la phrase parfois, pas toujours
String maybe(String[] words) { //renvoie true ou false de façon aléatoire.
  if (rand.nextBoolean()) return " " + words[rand.nextInt(words.length)]; //Si true : on retourne " " + un mot aléatoire du tableau words
  return ""; //Si false : on retourne une chaîne vide "".
}
// Cela permet d’ajouter des adjectifs ou adverbes facultativement dans les phrases

//Générer une phrase plus longue et poétique
String longer() {
  return " mon / ma" + maybe(adjectives) + " " + nouns[rand.nextInt(nouns.length)] //maybe(adjectives) : ajoute éventuellement un adjectif avant le nom / nouns[rand.nextInt(nouns.length)] : choisit un nom aléatoire pour le sujet.
    + maybe(adverbs) + " " + verbs[rand.nextInt(verbs.length)] //maybe(adverbs) : ajoute éventuellement un adverbe avant le verbe, verbs[rand.nextInt(verbs.length)] : verbe aléatoire.
    + " ton / ta" + maybe(adjectives) + " " + nouns[rand.nextInt(nouns.length)] + ".";
}


//Générer une phrase courte et simple.
String shorter() {
  return " " + adjectives[rand.nextInt(adjectives.length)] + " " + nouns[rand.nextInt(nouns.length)] + "."; //Choisit un adjectif et un nom au hasard.
}

//Générer un corps de poème composé de 5 phrases aléatoires.
String body() {
  String text = ""; //Commence vide
  boolean youAre = false; //indique si la dernière phrase est "You are my ..."
  for (int i=0; i<5; i++) {
    String type = rand.nextBoolean() ? "longer" : "shorter"; //Choisit aléatoirement longer ou shorter.
    if (type.equals("longer")) {
      text += longer(); //la dernière phrase n’est pas du type "You are my"
      youAre = false;
    } else {
      if (youAre) {
        text = text.substring(0, text.length()-1) + ": mon / ma" + shorter(); ////Si la dernière phrase était déjà "You are my" → remplace le dernier point par ": my" + nouveau shorter().
        youAre = false; 
      } else {
        text += " Tu es mon / ma" + shorter(); //Sinon ajoute " You are my" + shorter() et marque youAre = true.
        youAre = true;
      }
    }
  }
  return text;
}

//Générer la lettre complète.

String letter() {
  String text = first[rand.nextInt(first.length)] + " " + second[rand.nextInt(second.length)] + "\n\n" //Salutation aléatoire
    + body() + "\n\n" //Appelle body pour générer la letter
    + "                            Ton " + adverbs[rand.nextInt(adverbs.length)] + "\n\n"
    + "                                  M.U.C.\n";
  return text;
}
