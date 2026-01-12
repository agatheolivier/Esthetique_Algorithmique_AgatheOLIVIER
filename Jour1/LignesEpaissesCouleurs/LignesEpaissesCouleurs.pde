void setup() {
  size(640, 400); //Crée une fenêtre de 640 / 400 px
  background(255); //rend le fond blanc
}

void draw (){
  //Dans le draw car sinon ça continue de créer des rectangles à l'infinie
  int N = 0; //On initie la variable N, c'est la marge intérieur pour décaler les rectangles
  int X = 639; //Dernier pixel, comme on commence à 0 on doit enlever un au résultat
  int Y = 399; //Pareil
  int D = 0; //Epaisseur, c'est comme ça que ça augmente au fur et à mesure
  do {
      D = D+1; //épaisseur des lignes qui augmente à chaque boucle
      strokeWeight(D); //Applique cette épaisseur au tracé
  
      N = N+D+1; //Le coin haut-gauche avance => plus vite quand les lignes sont épaisses (pour éviter que les rectangles se chevauchent)
      X=X-D-10; //Détermination des coordonnées du rectangle, décalage de 10 pour l'effet escalier
      Y=Y-D-10; //(N,N) 
      
      float R = random(0, 256); //Rouge
      float V = random(0, 256); //Vert
      float B = random(0, 256); //Bleu
      
      fill(R, V, B);
      
      R = random(0, 256); //Rouge
      V = random(0, 256); //Vert
      B = random(0, 256); //Bleu
      stroke(R, V, B);
      
      rect(N, N, X - N, Y - N);
  }
    
  while (N < Y); //On continue tant que le rectangle a encore une hauteur positive
  
  delay(1000);
}
