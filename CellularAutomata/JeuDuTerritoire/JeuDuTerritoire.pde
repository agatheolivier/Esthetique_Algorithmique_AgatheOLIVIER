// ************************************************************************************************* GRILLE DE JEU ********************************************************************************************************************
int debut = 0; // stockera le moment de départ
int duree = 30000; // 30 secondes = 30000 ms

int cols = 50; // nombre de colonnes
int rows = 50; // nombre de lignes
int[][] grid = new int[cols][rows];
float w = 0; 
float h = 0; 

void setup() {
  size(700, 700); // taille de la fenêtre
  frameRate(100); // vitesse de l'automate
  initialisation();
  w = width / cols; 
  h = height / rows; 
  debut = millis(); // fonction millis() retourne le nombre de millisecondes écoulées depuis le début du programme.
}

void grilleDeJeu() {
  background(255); // fond blanc
  float w = width / cols; // largeur d'un carré => calculer automatiquement avec la largeur de la fenêtre
  float h = height / rows; // hauteur d'un carré

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      stroke(0); // couleur du contour
      strokeWeight(0.5);
      if (grid[i][j] == 1) {
        fill(200, 0, 0); //En fonction de l'état de la cellule, plus simple pour les vérifications
      } else if (grid[i][j] == 2) {
        fill(0, 0, 200);
      }
      else {
        fill(255); // couleur de remplissage à blanc au début
      } 
      rect(i * w, j * h, w, h); // dessiner le carré => utiliser rect plutôt que line pour pouvoir colorer
    }
  }
}

// ************************************************************************************************* AUTOMATES CELLULAIRES *************************************************************************************************************

int x1, y1, x2, y2;

void initialisation() {
   x1 = int(random(50)); // 0 à 49
   y1 = int(random(50)); // 0 à 49
   grid[x1][y1] = 1;
   
   x2 = int(random(50)); // 0 à 49
   y2 = int(random(50)); // 0 à 49
   if (grid[x2][y2] == 1){
      x2 = int(random(50)); // 0 à 49
      y2 = int(random(50)); // 0 à 49
   }
   grid[x2][y2] = 2;
}

void automateRouge() {
  // voisins diagonaux inclus
  int[][] voisins = {
    {-1,-1}, {0,-1}, {1,-1},
    {-1, 0},         {1, 0},
    {-1, 1}, {0, 1}, {1, 1}
  }; //Liste des position possible

  int[] v = voisins[int(random(voisins.length))]; // random(voisins.length) retourne un nombre flottant entre 0 et 8 (exclu),  int(...) convertit ce nombre en entier 0–7, pour choisir un index dans le tableau.
  int nx = constrain(x1 + v[0], 0, cols-1); //x1 + v[0] → nouvelle coordonnée X du voisin choisi
  int ny = constrain(y1 + v[1], 0, rows-1);
  //constrain(val, min, max) limite la valeur pour rester dans la grille :
  //si nx < 0, il devient 0
  //si nx >= cols, il devient cols-1

  // on écrase la case quelle que soit sa couleur
  grid[nx][ny] = 1;

  x1 = nx;
  y1 = ny;
}

void automateBleu() {
  int[][] voisins = {
    {-1,-1}, {0,-1}, {1,-1},
    {-1, 0},         {1, 0},
    {-1, 1}, {0, 1}, {1, 1}
  };

  int[] v = voisins[int(random(voisins.length))];
  int nx = constrain(x2 + v[0], 0, cols-1);
  int ny = constrain(y2 + v[1], 0, rows-1);

  grid[nx][ny] = 2; // écrase la case
  x2 = nx;
  y2 = ny;
}
// **************************************************************************************************** GAMEPLAY ***********************************************************************************************************************

void draw() {
  grilleDeJeu();
  
  int tempsEcoule = millis() - debut; //(temps depuis lancement) - (temps au début du jeu)
  
  fill(0); // couleur du texte (noir)
  textSize(16); // taille du texte
  text("Temps : " + (30 - tempsEcoule / 1000) + " s", 10, 20); //10 → distance en pixels depuis le bord gauche, 20 → distance en pixels depuis le bord supérieur

  if (tempsEcoule >= duree) {
    // fin de partie : compter les cases
    int rouge = 0;
    int bleu = 0;
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (grid[i][j] == 1) {
          rouge++; 
        }
        else if (grid[i][j] == 2){
          bleu++;
        }
      }
    }

    if (rouge > bleu) {
      // dimensions du rectangle (un peu plus grandes que le texte)
      float rectW = 600;
      float rectH = 160;
      
      // rectangle blanc
      fill(255); // blanc
      noStroke();
      rectMode(CENTER);
      rect(width/2, 370, rectW, rectH);
      
      fill(0); // couleur du texte (noir)
      textSize(40); // taille du texte
      textAlign(CENTER, CENTER);
      text("Les rouges ont gagnés", width/2, height/2); 
      String msg = "Rouge : " + rouge + "   Bleu : " + bleu;
      text(msg, width/2, height/2 + 40);
    }
    else if (bleu > rouge) {
      // dimensions du rectangle (un peu plus grandes que le texte)
      float rectW = 600;
      float rectH = 160;
      
      // rectangle blanc
      fill(255); // blanc
      noStroke();
      rectMode(CENTER);
      rect(width/2, 370, rectW, rectH);
      
      fill(0); // couleur du texte (noir)
      textSize(40); // taille du texte
      textAlign(CENTER, CENTER);
      text("Les bleues ont gagnés", width/2, height/2);
      String msg = "Rouge : " + rouge + "   Bleu : " + bleu;
      text(msg, width/2, height/2 + 40);
    }
    else println("Egalité !");

    noLoop(); // arrête draw()
  }
  else {
    // partie en cours : déplacer les points
    automateRouge();
    automateBleu();
  }
}
