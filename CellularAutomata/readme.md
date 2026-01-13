# Agathe OLIVIER - Workshop Esthétique et algorithmique 

## Introduction

J'ai choisi d'utiliser processing pour cette semaine. Pour accèder au rendu, il suffit de l'installer et d'ouvrir le **fichier point pde** dedans.

## Jeu du territoire

Pour aujourd'hui, j'ai décidé deux réaliser deux automates cellulaires, un rouge et un noir, soumis aux mêmes règles : 

Le premier point est placé aléatoirement sur une grille de 50 par 50 cases.

Ensuite, un second point est placé à côté du premier, sa position (haut, bas, côté ou diagonale) est aléatoire, et ainsi de suite.

Les points peuvent en écraser un précédent.

Au bout d'une minute, l'automate cellulaire qui a coloré le plus de case a gagné.

## Réalisation

J'ai réalisé ce jeu à l'aide de mes connaissances. Je me suis servis de l'IA pour débuger, en particulier pour le système de valeur (1 et 2) qui permet de vérifier plus facilement les victoires, et également pour le gérer les bords du plateau pour éviter les erreurs.

Je m'en suis également servit pour corriger mes automates cellulaires. A l'origine, j'avais ce code : 
```processing
void automatesCellulaires() { 
    int NouveauX1 = constrain(x1 + int(random(-1, 2)), 0, cols-1);
    int NouveauY1 = constrain(y1 + int(random(-1, 2)), 0, rows-1); 
    
    while (grid[NouveauX1][NouveauY1] == 1){ 
        NouveauX1 = constrain(x1 + int(random(-1, 2)), 0, cols-1);
        NouveauY1 = constrain(y1 + int(random(-1, 2)), 0, rows-1);
    };

    grid[NouveauX1][NouveauY1] = 1;
    x1 = NouveauX1;
    y1 = NouveauY1;
        
    int NouveauX2 = constrain(x2 + int(random(-1, 2)), 0, cols-1);
    int NouveauY2 = constrain(y2 + int(random(-1, 2)), 0, rows-1);
        
    while (grid[NouveauX2][NouveauY2] == 2){
        NouveauX2 = constrain(x2 + int(random(-1, 2)), 0, cols-1);
        NouveauY2 = constrain(y2 + int(random(-1, 2)), 0, rows-1);
    };
    grid[NouveauX2][NouveauY2] = 2; 
    x2 = NouveauX2; 
    y2 = NouveauY2;
}
```
Mais dès que les deux couleurs entrées en colision, le programme s'arrêtait.

C'est pourquoi je l'ai changé par la version actuelle où les deux couleurs sont dans des fonctions séparées.