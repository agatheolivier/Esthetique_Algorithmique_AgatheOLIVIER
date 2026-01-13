// ************************************************************************************************* GRILLE DE JEU ********************************************************************************************************************

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
        fill(150, 0, 0); //En fonction de l'état de la cellule, plus simple pour les vérifications
      } else if (grid[i][j] == 2) {
        fill(50, 0, 0);
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
  };

  int[] v = voisins[int(random(voisins.length))]; // choisir un voisin au hasard
  int nx = constrain(x1 + v[0], 0, cols-1);
  int ny = constrain(y1 + v[1], 0, rows-1);

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
boolean victoireRouge() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j] != 1) return false; // si une case n'est pas rouge
    }
  }
  return true; // toutes sont rouges
}

boolean victoireBleu() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j] != 2) return false; // si une case n'est pas bleu
    }
  }
  return true; // toutes sont rouges
}

void draw() {
  grilleDeJeu();
  
  // Vérifier si toutes les cases sont rouges
  if (victoireRouge()) {
    println("Les rouges ont gagné, arrêt du programme.");
    noLoop(); // arrête draw()
  }
  else if (victoireBleu()) {
    println("Les bleues ont gagné, arrêt du programme.");
    noLoop(); // arrête draw()
  }
  else {
    automateRouge();
    automateBleu();
  }
}
