//************************************************************************************************************ BIBLIOTHEQUE *****************************************************************************************************

import ddf.minim.*; //pour lire le MP3 et manipuler le son
import ddf.minim.analysis.*; //pour faire l’FFT, qui analyse les fréquences
import java.util.ArrayList; //pour stocker dynamiquement les points à afficher

//************************************************************************************************************ VARIABLES GLOBALES *****************************************************************************************************

Minim minim; //objet principal pour gérer le son.
AudioPlayer chanson; //notre MP3 à jouer.
FFT fft; //analyseur de fréquences

ArrayList<MusiquePoint> points; //liste de tous les points dessinés à l’écran (mélodie + basses), ils sont de classe MusiquePoint

//************************************************************************************************************ CLASSE MUSICPOINT *****************************************************************************************************

class MusiquePoint {
  float x, y, transparence, vitesseDisparition, taille; //x et y position
  color couleur; //couleur
  
  MusiquePoint(float x, float y, float taille, color couleur) {
    this.x = x; this.y = y;
    this.taille = taille;
    this.couleur = couleur;
    this.transparence = 255; //255 = visible et 0 = invisible
    this.vitesseDisparition = random(3,6); //Aléatoire pour que ce soit plus dynamique
  }
  
  //Fonction en lien avec l'objet
  
  void transparence() { 
    transparence -= vitesseDisparition;
  } //diminue la transparence à chaque frame
  
  void Point() {
    stroke(couleur, transparence);
    strokeWeight(taille); //Epaisseur du trait => taille du point
    point(x, y);
  } //dessine le point avec sa couleur et taille
  
  boolean Invisible() { 
    return transparence <= 0; //retourne vrai si le point est complètement transparent => on le supprime de la liste.
  } 
}

//************************************************************************************************************ SETUP *****************************************************************************************************


void setup() {
  size(1000,1000); //taille de la fenêtre
  minim = new Minim(this); //initialise Minim
  chanson = minim.loadFile("LindseyStirling_CarolOfTheBells.mp3",2048); //charge le MP3
  chanson.play(); //lance la lecture à l'ouverture de la fenêtre
  
  fft = new FFT(chanson.bufferSize(), chanson.sampleRate()); //initialise l’analyseur de fréquence avec la taille du buffer et la fréquence d’échantillonnage du MP3.
  points = new ArrayList<MusiquePoint>(); //initialise la liste vide des points.
  background(0); //fond noir
}

//************************************************************************************************************ ETATS DU SON *****************************************************************************************************

float[] AmplitudePrecedente; //tableau pour stocker les valeurs de chaque bande de fréquence de la mélodie au frame précédent
float bassPrecedente = 0; //pour détecter les pics de basses

//************************************************************************************************************ AFFICHAGE *****************************************************************************************************

void draw() {
  if (modeTableau) {
    background(0); //Supprimer si on veut un tableau de points
  }
  fft.forward(chanson.mix); //calcule le spectre de fréquences pour le son actuel. song.mix combine les canaux gauche/droite.
  
  //Potentiellement deux points : un pour l'instru / les basses, et un pour la mélodie => c'est plus dynamique et il faut prendre les deux en compte pour transmettre plus de "sentiments"
  
  // On définit la plage de fréquence de la mélodie : 200 Hz → 5000 Hz.
  int startIndex = fft.freqToIndex(200); //fft.freqToIndex(freq) convertit une fréquence en l’indice correspondant dans le tableau FFT.
  int endIndex = fft.freqToIndex(5000);  
  
  // Amplitude : c'est à quel point la fréquence est présente par rapport aux autres. Si elle est plus présente que les autres (donc si elle a une grande amplitude), c'est quelle est joué à l'instant t
  //Forcément il y a beaucoup de fréquence dans une musique, mais on s'interesse à celle que notre oreille remarque le plus pour trouvé la mélodie
  
  if (AmplitudePrecedente == null) {
    AmplitudePrecedente = new float[fft.specSize()];
  } //Si il n'y a pas de fréquence précédente, on la crée avec la taille du spectre (fft.specSize()).
  
  //On cherche le pic le plus fort dans la plage de la mélodie :
  int maxIndex = -1;
  float maxDiff = 0; // Permet de mesurer combien le son a augmenté par rapport à la frame précédente (un pic dans la mélodie).
  
  //Parmis toutes les fréquences qu'on considère comme mélodie
  for (int i = startIndex; i <= endIndex; i++) {
    float diff = fft.getBand(i) - AmplitudePrecedente[i]; //Quelle fréquence a soudain augmenté, c’est qu'elle est joué.fft.getBand(i): amplitude actuelle de la bande i à ce frame
    if (diff > 2 && diff > maxDiff) { // seuil pour ignorer les variations faibles (musique de fond ou instrumental).
      maxDiff = diff; //On stocke la note qui a le plus d'amplitude, donc celle en train d'être joué
      maxIndex = i; //Stocke quel est le pic le plus fort
    }
    AmplitudePrecedente[i] = fft.getBand(i); //On stocke la fréquence
  }
  
  if (maxIndex != -1) { //Si on a trouvé un pic, alors on affiche un point : pas d'erreur quand la musique est à l'arrêt
    float x = random(width); //Position aléatoire sur l'écran
    float y = random(height);
    float taille = map(maxDiff, 2, 50, 6, 30); // Taille du point proportionnelle à l’intensité du pic (maxDiff), 12 taille minimal et 25 maximal
    float freq = fft.indexToFreq(maxIndex); //fréquence du pic pour déterminer la couleur
    
    colorMode(HSB, 360, 100, 100, 255);

    float freqMin = 200;   // début mélodie
    float freqMax = 5000;  // fin mélodie

    float hue = map(freq, freqMin, freqMax * 0.6, 240, 0); //*0,6 pour faire apparaitre les rouges plus vites
    hue = constrain(hue, 0, 240);   
    color couleur = color(hue, 50, 100);
    
    // t = 0 pour la fréquence la plus basse, t = 1 pour la plus haute
    float t = map(freq, 200, 5000, 0, 1); //Donne l'équivalent de la fréquence comprise entre 200 et 5000 dans l'interval 0,1
    t = constrain(t, 0, 1); // pour rester entre 0 et 1, comme pour le jeu de terrain qui devait rester dans la fenêtre
    t = pow(t, 0.5);  // racine carrée pour atteindre plus vite le rouge, sinon la génération reste bleu
        
    points.add(new MusiquePoint(x, y, taille, couleur)); //On ajoute un nouveau point à la liste
  }
  
  //fréquences basses du morceau (20 Hz à 200 Hz), là où se trouvent les basses et percussions graves
  // Basses (20 Hz à 200 Hz)
  int startBass = fft.freqToIndex(20); //FFT ne travaille pas en Hz directement mais par index de bande
  int endBass = fft.freqToIndex(200);
  
  float bassLevel = 0;
  for (int i = startBass; i <= endBass; i++) {
    bassLevel += fft.getBand(i); // fft.getBand(i) permet de lire une bande spécifique, on additionne toutes les amplitudes des bandes basses pour obtenir bassLevel : un seul chiffre représentant l’énergie globale des basses à ce moment précis.
  }
  
  if (bassLevel - bassPrecedente > 3) {
    float x = random(width);
    float y = random(height);
    float taille = map(bassLevel - bassPrecedente, 3, 50, 1, 3); //Si l’augmentation est faible :  petit point (2 px).
    color couleur = color(50,50,200); //couleur bleue pour les basse
    points.add(new MusiquePoint(x, y, taille, couleur));
  }
  bassPrecedente = bassLevel;
  
  // -------------------
  // Mise à jour et affichage
  for (int i = points.size()-1; i>=0; i--) {
    MusiquePoint p = points.get(i); //Le points actuels s'appelle p
    p.transparence(); //transparence est compris dans la class de p
    p.Point(); //dessine le point.
    if (p.Invisible()) points.remove(i); //supprime les points totalement transparents pour ne pas saturer la mémoire.
  }
}
//************************************************************************************************************ MODE *****************************************************************************************************
boolean modeTableau = true;
int musique = 1;

void keyPressed() {
  if (key == ' ') {
    modeTableau = !modeTableau;
  }
  if (keyCode == RIGHT || keyCode == LEFT ) {
    if ( musique == 1) {
       chanson.close();
       background(0);
       chanson = minim.loadFile("JVKE_HerFtZVC.mp3", 2048);
       musique = 2;
    } else {
       chanson.close();
       background(0);
       chanson = minim.loadFile("LindseyStirling_CarolOfTheBells.mp3", 2048);
       musique = 1;
    }
    chanson.play();
  }
}
