void setup() {
  size(1000, 500);
  background(180, 220, 255);  // Fond bleu en RVB
  noFill();         // Pas de remplissage pour l'instant
}

void draw() {
  // ******************************************************************************************* COULEURS *****************************************************************************************************************
  
  //colorMode() permet de définir le système de couleur utilisé dans Processing.
  //HSB signifie : Hue (teinte), Saturation, Brightness (luminosité).
  //Les valeurs maximales :
  //Hue : 0 → 360 (angle sur le cercle chromatique)
  //Saturation : 0 → 100 (0 = gris, 100 = couleur pure)
  //Brightness : 0 → 100 (0 = noir, 100 = lumineux / clair)
  
  colorMode(HSB, 360, 100, 100); // changer le mode couleur
  
  color[] couleur = new color[14]; // créer un tableau vide de type color de 7 couleurs
  
  for (int a = 0; a < 14; a++) {
    float h = map(a, 0, 14, 0, 360); // teintes réparties uniformément, map(value, start1, stop1, start2, stop2), résultat = 0 + (a -0) x ((360-0)/(7-0) = a x 360 / 7
    float s = random(20, 50);    // Saturation faible : Pastel, pas trop pour ne pas tomber dans des couleurs grisés
    float b = random(80, 100);    // luminosité élevée pour couleurs claires
    couleur[a] = color(h, s, b);
  }
  
 //du rouge vers le violet (ordre croissant), selon la teinte hue
  for (int b = 0; b < couleur.length-1; b++) {
    for (int j = b + 1; j < couleur.length; j++) { //Compare la couleur b avec toutes les couleurs suivantes dans le tableau (j = b+1 → fin).
      if (hue(couleur[b]) > hue(couleur[j])) {
        color temp = couleur[b];
        couleur[b] = couleur[j];
        couleur[j] = temp;
        //Si la teinte de b est plus grande que celle de j, on veut échanger les deux pour que la plus petite teinte vienne avant.
      }
    }
  }

  // ******************************************************************************************* ARC EN CIEL *****************************************************************************************************************

  int x = 500;
  int y = 500;
  int rayon = 1400; // Rayon de l'arc extérieur (le plus grand)
  int espace = 100; // Espace entre les arcs

  // dessiner les 7 arcs
  for (int i = 0; i < 14; i++) {
    stroke(couleur[i]);  
    fill(couleur[i]);
    arc(x, y, rayon - i*espace, rayon - i*espace, PI, TWO_PI); //arc(x, y, largeur (qui baissent à chaque fois), hauteur (qui baissent à chaque fois), start, stop)
  }
  
  //Pour que le dernier arc soit bleu aussi
  //fill(208, 29, 100); //Fond bleu en HSB
  //arc(x, y, 200, 200, PI, TWO_PI);
  delay(1000);
}
