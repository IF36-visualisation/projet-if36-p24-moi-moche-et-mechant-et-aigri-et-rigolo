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

Les données du dataset proviennent du site eSportsEarning.com , ce dataset comporte 3 parties distinctes :

1. country-and-continent-codes-list.csv
**Nombre d’observations** (lignes) : 262  
**Nombre de variables** (colonnes) : 6  
Détails des variables :

| Nom de variable           | Définition de variable    | Type de variable                                |
|---------------------------|---------------------------|-------------------------------------------------|
| Continent_Name            | Nom du continent          | type texte, 7 valeurs uniques, ex. Asia, Europe |
| Continent_Code            | Code du continent         | type texte, 6 valeurs uniques, ex. AS, EU       |
| Country_Name              | Nom complet du pays       | type texte, 254 valeurs uniques                 |
| Two_Letter_Country_Code   | Code pays à deux lettres  | type texte, 253 valeurs uniques                 |
| Three_Letter_Country_Code | Code pays à trois lettres | type texte, 250 valeurs uniques                 |
| Country_Number            | Numéro du pays            | type numérique, 250 valeurs uniques             |

Les données peuvent être regroupées par continent (Continent_Name et Continent_Code), offrant une catégorisation géographique des pays (Country_Name, Two_Letter_Country_Code, Three_Letter_Country_Code).
Ce fichier semble principalement fournir une correspondance entre les pays et leur appartenance continentale, sans sous-groupes internes évidents au-delà de cette classification géographique.


2. highest_earning_players.csv

**Nombre d’observations**: 96  
**Nombre de variables** : 8  
Détails des variables :

| Nom de variable           | Définition de variable    | Type de variable                                |
|---------------------------|---------------------------|-------------------------------------------------|
| PlayerId            | Identifiant du joueur          | type numérique, 998 valeurs uniques |
| NameFirst            | Prénom du joueur         | type texte, 756 valeurs uniques       |
| NameLast              | Nom de famille du joueur      | type texte, 637 valeurs uniques                 |
| CurrentHandle   | Pseudo actuel du joueur  | type texte, 990 valeurs uniques                 |
| CountryCode | Code pays du joueur | type texte, 56 valeurs uniques                 |
| TotalUSDPrize            | Total des gains en USD            | type numérique             |
| Game | Jeu | type texte, 10 genres de jeu différents                 |
| Genre            | Genre du jeu            | type texte, 5 genres différents             |

Les données sont organisées autour des joueurs et leurs gains dans différents jeux vidéo.
Catégories Principales : Les joueurs peuvent être catégorisés par le jeu (Game) auquel ils participent, et par genre de jeu (Genre), comme les jeux de tir à la première personne ou les arènes de bataille en ligne multijoueur.
Sous-groupes Possibles : Au sein de chaque jeu ou genre, des analyses peuvent être effectuées sur des sous-groupes, tels que les joueurs par pays (CountryCode), ou les tranches de gains (TotalUSDPrize).


3. highest_earning_teams.csv

**Nombre d’observations** : 87  
**Nombre de variables** : 6  
Détails des variables :

| Nom de variable           | Définition de variable    | Type de variable                                |
|---------------------------|---------------------------|-------------------------------------------------|
| TeamId            | Identifiant de l'équipe          | type numérique, 505 valeurs uniques |
| TeamName            | Nom de l'équipe         | type texte, 505 valeurs uniques       |
| TotalUSDPrize              | Total des gains en USD      | type numérique                |
| TotalTournaments   | Total des tournois disputés  | type numérique                |
| Game | Jeu | type texte, 10 genres de jeu différents                 |
| Genre            | Genre du jeu            | type texte, 5 genres différents             |

Semblable aux données des joueurs, celles-ci sont organisées autour des équipes et de leurs performances financières dans le domaine des esports.
Catégories Principales : Les équipes peuvent être catégorisées par jeu (Game) et par genre de jeu (Genre), offrant un aperçu des domaines où elles ont le plus de succès.
Sous-groupes Possibles : Il pourrait y avoir des analyses sur le nombre de tournois disputés (TotalTournaments) par rapport aux gains totaux, ou des comparaisons entre les genres de jeux pour voir où les équipes réussissent le plus.

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

### eSports Earnings

Voici quelques exemples d'interrogations sur ce dataset : 

**- Moyenne des gains des joueurs en fonction de leur nationalité ?** 

Cette analyse vise à déterminer si certaines nationalités sont plus susceptibles de gagner des sommes d'argent plus élevées dans le monde d'Overwatch 2. Cela pourrait révéler des tendances intéressantes, comme la possibilité que certaines régions offrent un meilleur soutien, formation, ou plus d'opportunités pour leurs joueurs. Les résultats pourraient indiquer des écarts de performance ou de popularité du jeu selon les pays.

**- Moyenne des gains des joueurs par continent ?**

Semblable à l'analyse par nationalité, mais à une échelle plus large, cette question cherche à comparer les gains moyens sur différents continents. Cela peut aider à comprendre comment les infrastructures régionales, la popularité du jeu, et le niveau de compétition influencent les récompenses financières. Cela pourrait également révéler des continents où le jeu est plus compétitif ou plus prisé.

**- Moyenne de gains des équipes par tournoi ?**

Cette analyse vise à évaluer le succès financier des équipes à travers différents tournois. Cela peut révéler quelles équipes dominent la scène d'Overwatch 2 et comment la distribution des prix varie entre les tournois. Cela peut également aider à identifier des tournois particulièrement lucratifs ou compétitifs.

**- Nationalités des joueurs les mieux payés ?**

En identifiant les nationalités des joueurs les mieux rémunérés, on peut tenter de déduire non seulement où se trouvent les talents les plus prometteurs ou les plus accomplis, mais aussi où le jeu est le plus valorisé. Cette information peut indiquer des tendances de recrutement pour les futures équipes ou des zones cibles pour le développement des ligues et des tournois.
