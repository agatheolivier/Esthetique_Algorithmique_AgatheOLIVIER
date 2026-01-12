int N = 0; //On initie la variable N, c'est la marge intérieur pour décaler les rectangles
int X = 639; //Dernier pixel, comme on commence à 0 on doit enlever un au résultat
int Y = 399; //Pareil
int D = 0; //Epaisseur, c'est comme ça que ça augmente au fur et à mesure

size(640, 400); //Crée une fenêtre de 640 / 400 px
background(255); //rend le fond blanc

do {
    D = D+1; //épaisseur des lignes qui augmente à chaque boucle
    strokeWeight(D); //Applique cette épaisseur au tracé

    N = N+D+1; //Le coin haut-gauche avance => plus vite quand les lignes sont épaisses (pour éviter que les rectangles se chevauchent)
    X=X-D-10; //Détermination des coordonnées du rectangle, décalage de 10 pour l'effet escalier
    Y=Y-D-10; //(N,N) 
    
    line(N, N, N, Y); //gauche, sous la forme (x1, y1, x2, y2), donc on va d'un point 1 à un point 2
    line(N, Y, X, Y); //bas
    line(X, Y, X, N); //droite
    line(X, N, N, N); //haute
}
  
while (N < Y); //On continue tant que le rectangle a encore une hauteur positive
  
delay(100);
