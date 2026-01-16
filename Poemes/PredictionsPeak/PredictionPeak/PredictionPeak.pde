PFont maFont;
PFont maFont2;
PImage bg; // variable pour stocker l'image

void setup() {
  size(1000, 587); // taille de la fenêtre
  background(255); // fond blanc
  bg = loadImage("PeakFond.png"); 
  maFont = createFont("Jazking Regular.otf", 40);
  maFont2 = createFont("Arial-Bold-48.vlw", 48); // nom exact du fichier .vlw
  textFont(maFont);
}

// ************************************************************************************************** VALEURS **************************************************************************************************

String prediction; // variable globale

String[] adjectifFeminin = {"calme", "dangereuse", "difficile", "facile", "tranquille", "mystérieuse", "imposante", "raide", "technique", "facile", "abordable", "risquée", "périlleuse", "glissante", 
"escarpée", "lumineuse", "enneigée", "désertique"};

String[] verbe = {"gagneras", "tomberas", "monteras", "chuteras", "perdras", "échouras", "mourras", "survivra", "réussiras", "te rattrapera", "te soigneras", "grimperas", "te battras"};

String[] liaison = {"avec", "en trouvant", "pour avoir", "grâce à"};

String[] objet = { "un antidote", "des bandages", "un remède universel", "un crâne maudit", "une noix de coco", "des baies croustillantes", "un oeuf", "une boisson énergisante", "une barre de céréales", "une boisson énergisante",
"des Cookies de scout", "un canon à corde", "une bobine de corde", "un piton", "un lance chaîne", "un haricot magique", "une boussole", "une lanterne", "un réchaud", "une trousse de premiers soins", "un remède champignon",
"une peau de banane", "Bing Bong", "des jumelles", "un disque volant", "un parchemin", "un parasol", "un ballon", "un zombie"};

String[] zone = {  "la plage", "la forêts de racines", "la montagne enneigée", "le désert", "l'entrée du volcan", "le Fourneau"};

String[] verbeIls = {"t'aiderons", "te feront perdre", "te tuerons", "te sauverons", "seront trop forts", "t'empoisonnerons (attention à Yanis)", 
"te guiderons", "t'amènerons à la victoire", "t'attendrons", "te rattraperons", "te réssuciterons"};

String[] adjectif = {"calme", "dangereuse", "difficile", "facile", "intense", "rapide", "imprévisible", "stratégique", "longue", "courte", "tendue", "stimulante", "épique", "chaotique", "exigeante", "variée",
"amusante", "stressante", "rapide", "fluide", "technique", "risquée", "palpitante", "mémorable", "surprenante", "inattendue", "passionnante"};

// ************************************************************************************************** GENERATION DU TEXTE **************************************************************************************************

void prediction() {
    prediction = "Aujourd'hui la montagne sera " + adjectifFeminin[int(random(adjectifFeminin.length))] + "." +
    " Tu " + verbe[int(random(verbe.length))] + " " + liaison[int(random(liaison.length))] + " " + objet[int(random(objet.length))] + " dans " + zone[int(random(zone.length))] + "." +
    " Tes coéquipiers " + verbeIls[int(random(verbeIls.length))] + " " + liaison[int(random(liaison.length))] + " " + objet[int(random(objet.length))] + "." + "\n\n" +
    " Cette game sera " + adjectif[int(random(adjectif.length))] + ".";
}


// ************************************************************************************************** AFFICHAGE **************************************************************************************************

//Accueil
float bx = 400;
float by = 300;
float bWidth = 200;
float bHeight = 100;

//Prédiction
float bx2 = 400;
float by2 = 375;
float bWidth2 = 200;
float bHeight2 = 70;

boolean boutonClique = false; // variable d'état

void draw() {
  // Affiche l'image à la position (0, 0) et taille de la fenêtre
  image(bg, 0, 0, width, height);
  
  //Rectangle blanc sous le texte
  float rectWidth = 700;
  float rectHeight = 400;

  float x = width/2 - rectWidth/2;
  float y = height/2 - rectHeight/2;
  
  fill(255, 255, 255, 220); // blanc semi-transparent
  noStroke(); // sans bordure
  rect(x, y, rectWidth, rectHeight, 10);
  
  if (!boutonClique) {
      //Titre
      textFont(maFont);
      fill(119, 48, 136); // couleur pour le texte
      textSize(60); // taille du texte
      textAlign(CENTER, TOP); // centre horizontalement
      text("Prédiction pour ta game de Peak", 200, 150, 600, 600);
      
      // Dessine le bouton
      fill(252, 173, 133); // couleur du bouton
      stroke(201, 98, 170);
      strokeWeight(5);
      rect(bx, by, bWidth, bHeight, 10); // 10 = coins arrondis
    
      // Texte du bouton
      textFont(maFont2);
      fill(119, 48, 136);
      textSize(30); // taille du texte
      text("Obtenir ma prédiction", bx, by+22, 200, 200);
  }
  else {
       //Titre
      textFont(maFont);
      fill(119, 48, 136); // couleur pour le texte
      textSize(60); // taille du texte
      textAlign(CENTER, TOP); // centre horizontalement
      text("Ta prédiction", 200, 150, 600, 600);
      
      textFont(maFont2);
      fill(119, 48, 136);
      textSize(20); // taille du texte
      textAlign(LEFT); // centre horizontalement
      text(prediction, 200, 230, 600, 600); // texte fixe
      
      // Dessine le bouton
      fill(252, 173, 133); // couleur du bouton
      stroke(201, 98, 170);
      strokeWeight(5);
      rect(bx2, by2, bWidth2, bHeight2, 10); // 10 = coins arrondis
    
      // Texte du bouton
      textAlign(CENTER, TOP); 
      textFont(maFont2);
      fill(119, 48, 136);
      textSize(20); // taille du texte
      text("Obtenir une nouvelle prédiction", bx2+15, by2+15, 170, 170);
  }
}

// ************************************************************************************************** INTERACTIVITE **************************************************************************************************

//Détection du bouton
void mousePressed() {
  // Vérifie si le clic est dans le bouton
  if (mouseX > bx && mouseX < bx + bWidth &&
      mouseY > by && mouseY < by + bHeight) {
    boutonClique = true; // le bouton est cliqué donc on supprime le titre et le bouton
    prediction();
  }
  if (mouseX > bx2 && mouseX < bx2 + bWidth2 &&
      mouseY > by2 && mouseY < by2 + bHeight2) {
    boutonClique = true; // le bouton est cliqué donc on supprime le titre et le bouton
    prediction();
  }
}
