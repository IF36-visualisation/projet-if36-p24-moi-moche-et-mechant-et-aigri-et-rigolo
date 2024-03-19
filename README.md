[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Fj4cXJY4)
# Introduction

## Données
Les données viennent du site kaggle, nous les avons choisis car on voulait travailler sur un jeu-vidéo que nous aimons. Nous les avons également choisi car on a trouvé plusieurs dataset complémentaires et riche. Elles s'intègrent dans le contexte de l'esport et plus particulièrement dans le jeu-vidéo Overwatch

Nous avons 4 dataset différents donc nous allons faire 4 parties afin que ce soit plus clair.
### Overwatch 2 statistics

Ce dataset présente des statistiques sur les héros Overwatch (pick rate, pourcentage de victoires, dégats, etc...) en fonction du niveau du joueur (de bronze à diamand) et des saisons.

Le dataset se compose de 131 variables et 288 observations ; les colonnes les plus précises ne seront pas étudiées car leur contenu trop pointu ne nous intéresse pas.
Nous nous intéresserons à une dizaine de colonnes : 

**Hero** : Nom du héros (type texte, ex. Ana, Mercy)  
**Skill tier** : Définit le niveau de classement du joueur (type texte, 8 valeurs possibles : All, Bronze, Silver, Gold, Platinium, Diamond, Master ou Grandmaster)  
**KDA Ratio** : La somme de kills et des assistances divisée par le nombre de fois où le joueur est mort (type numérique)  
**Pick rate** : Le taux de sélection de chaque héros en jeu (type numérique)  
**Win Rate** : Le taux de victoire de chaque héros (type numérique)  
**Eliminations / 10min** : Nombre d'éliminations en moyenne sur 10 minutes de jeu (type numérique)  
**Damage / 10 min** :  Nombre moyen de dégâts du héros sur 10 minutes de jeu (type numérique)  
**Healing / 10 min** : Nombre moyen de points de vie récupéré/redonné sur 10 min de jeu (type numérique)  
**Role** : Rôle du héros en jeu (type texte, trois valeurs possibles : Damage, Tank ou Support) 

Ce dataset est divisé en 5 parties :
Une première reprend les infos ci-dessus en général depuis que le jeu est sorti.
Les quatres suivantes correspondent aux mêmes données mais pour chaque saison.

### Overwatch
### eSports Earnings
### Professional Overwatch Player Mouse/Sens. Settings

## Plan d'analyse

### Overwatch 2 statistics

Voici quelques exemple d'interrogations sur ce dataset : 

**- Quels héros sont les plus/moins joués ?**

Cette question seule sera difficile à analyser ; on aura des informations sur les héros les plus joués sans pouvoir définir pourquoi. Mais elle deviendra utile liée à d'autres questions ci-dessous, qui pourront (ou non) nous aider à comprendre les raisons poussant les joueurs à jouer certains héros plus que d'autres. 

**- Quels héros provoquent le plus/moins de dégâts ?**

Pour cette question, on s'attend à ce que les héros les plus offensifs (ayant le rôle "damage") soient ceux qui provoquent le plus de dégâts en moyenne. Au contraire, nous nous attendons à voir que les héros défensifs (rôle "support") provoquent bien moins de dégâts, sachant que ce n'est pas leur but premier. 

**- Quels héros ont le plus/moins de taux de victoire ?**

Il est difficile de prévoir le résultat de cette visualisation. Pour autant, elle peut être intéressante à lier à d'autres questions, ou en la spécifiant plus (par exemple, en se demandant quels sont les rôles des héros ayant le plus de victoires en moyenne, etc.)

**- Comment le ratio des héros a évolué en fonction des saisons ? (augmentation/diminution)**

Étudier l'évolution du KDA ratio des héros en fonction des saisons dans Overwatch pourrait permettre de comprendre les changements de popularité des héros au fil du temps (première question). Cela offre un aperçu des héros qui ont gagné en impact aidant à comprendre les tendances du jeu en fonction des saisons.

Dans l'ensemble, toutes ces questions peuvent être découpées :
- En fonction du niveau des joueurs (skill tier)
- En fonction des différentes saisons  
Permettant d'étudier sous différents angles toutes nos données. 


