int nbBranchesFlocon = 6; // On veut 6 branches comme un flocon pour le départ
float longueur = 70; //Longueur de la ligne de départ
int repetitions = 5; // L'utilisateur peut changer ce nombre pour contrôler la fractale

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100); // Passe en mode HSB pour gérer les couleurs facilement
}

//En dehors de setup, car setup est utilisé une seule fois. Si on laisse le code dedans, ça ne se mettra pas à jour quand on change le nombre de branche
void flocon () {
  background(0, 0, 100);
  pushMatrix(); // Sauvegarde le repère global
  translate(width/2, height/2); //Centre au milieu du canva

  for (int i = 0; i < nbBranchesFlocon; i++) {
    pushMatrix(); // Sauvegarde la position et rotation
    rotate(TWO_PI / nbBranchesFlocon * i); // Rotation pour chaque branche
    branche(longueur, repetitions);
    popMatrix(); // Retour au centre pour la prochaine branche
  }
  
  popMatrix(); // Restaure le repère global
}

void branche(float longueur, int repetitions) {
 // On utilise un tableau de "branches à dessiner"
  ArrayList<Branche> branchesactuelles = new ArrayList<Branche>(); //Crée une liste pour l'instant vide qui contiendra des objets de classe branche (toutes les branches à dessiner à ce niveau).
  branchesactuelles.add(new Branche(0, 0, -longueur, 0)); // Ajoute dans le tableau la branche actuelle
    
  for (int i = 0; i < repetitions; i++) { //Chaque itération correspond à un niveau de la fractale pour que l'utilisateur puisse choisir
    ArrayList<Branche> nextBranches = new ArrayList<Branche>(); //Créer un nouveau tableau vide qui contiendra les futurs branches
    float hue = map(i, 0, repetitions, 200, 240); //200 (bleu foncé) à 240 (bleu clair), map () transforme une valeur d'un interval à un autre

    stroke(hue, 50 - i, 100); // Saturation 50%, Brightness 100%
    strokeWeight(map(i, 0, repetitions, 3, 0.5)); // branches plus fines à l extérieur
    
    for (Branche b : branchesactuelles) { //On parcours le tableau de branches actuelles, à chaque itération, b prendra la valeur d'une des branches jusqu'à toutes les faires
      // x2 et y2 sont les extrémités de la branche.
      // En coordonné polaire, les points sont définies par leur distance à l'origine et l'angle par rapport à l'axe horizontal ou vertical
      float x2 = b.x + b.longueur * sin(b.angle); //Correspond aux coordonnés polaires, x2 = x + longueur * sin(angle + angleDelta);
      float y2 = b.y + b.longueur * cos(b.angle); 
      line(b.x, b.y, x2, y2);
      
      // Pour les branches suivantes
      float rotation = PI/8;
      float nouvelleLongueur = b.longueur / 1.2;
      
      // Branche à droite
      nextBranches.add(new Branche(x2, y2, nouvelleLongueur, b.angle + rotation)); //Ajoute dans le tableau nextBranches la nouvelle branche
      // Branche à gauche
      nextBranches.add(new Branche(x2, y2, nouvelleLongueur, b.angle - rotation));
    }
    
    branchesactuelles = nextBranches; // Passer au niveau suivant, on ne se préoccupe plus des anciennes branches
  }
}

class Branche { //On créé une classe branche
  float x, y, longueur, angle; //Pour chaque branche on stocke x, y, sa longueur et son angle
  
  Branche(float x, float y, float longueur, float angle) {
    this.x = x;
    this.y = y;
    this.longueur = longueur;
    this.angle = angle;
  }
}

void keyPressed() {
  if (key == '+' || key == '=' || keyCode == ADD) {
    nbBranchesFlocon++;
    flocon();
  } else if (key == '-' || key == '_' || keyCode == SUBTRACT) {
    nbBranchesFlocon = max(1, nbBranchesFlocon - 1); // au moins 1 branche
    flocon();
  }
  else if (keyCode == RIGHT) {
    repetitions++;
    flocon();
  }
  else if (keyCode == LEFT) {
    repetitions = max(1, repetitions - 1);
    flocon();
  }
}

void draw () {
  flocon();
}
