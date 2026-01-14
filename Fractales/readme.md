# Agathe OLIVIER - Workshop Esthétique et algorithmique 

## Introduction

J'ai choisi d'utiliser processing pour cette semaine. Pour accèder au rendu, il suffit de l'installer et d'ouvrir le **fichier point pde** dedans.

## Flocons de neige

Mon idée de base était de générer des flocons de neige aux motifs à l'aide de variables dont on changerait la valeur. Mais j'ai rencontré des problèmes pratiques : 

Je n'ai pas réussi à créer une branche puis la dupliquer en faisant une rotation. Mon code génère les branches indépendamment en décalant l'angle d'origine. C'est pourquoi si j'essayais d'inclure des valeurs aléatoires, ça cassait l'effet fractal car mes branches n'avaient plus la même longueur.

Je suis donc resté sur l'idée de flocon mais j'ai changé la pratique en ajoutant de l'interactivité.

**Les touches :**

- **+ : Ajouter une nouvelle branche**
- **- : Enlever une branche**
- **Flèche droite : Ajouter un motif de fractale**
- **Flèche gauche : Enlever un motif de fractale**

Avec un minimum de 1 branche et un trait.

## Réalisation

J'avais réalisé ce projet avec des fonctions récursives à l'origine, mais cette solution ne permet pas l'interactivité avec les touches.

Je me suis aidé de l'IA pour comprendre comment faire une version avec une boucle for et débugger le changement.

Je m'en suis également servi pour les coordonnées polaires et pour comprendre l'utilisation du pushMatrix.

Pour la structure, j'avais déjà une idée de comment faire comme je m'en suis déjà servi en JS, l'IA m'a uniquement servi à débugger des erreurs de syntaxes et pouvoir parcourir mes tableaux.

Enfin, j'ai repris mon principe de dégradé du projet du jour 1 mais en l'adaptant pour faire un dégradé de bleu.