# Fata

Fata est un utilitaire basique pour aider à la construction
d'histoires fictives - au sens de "déroulé d'événements généraux", pas
au sens de "récit".


En sollicitant des questions simples via la commande `fata ask`,
l'utilisateur est amené à rédiger progressivement un corpus de
fichiers Markdown.

## Fonctionnement

Fata travaille sur des fichiers présents dans un même dossier. On
distingue trois types de fichiers :

* ceux qui constituent le corpus à proprement parler ; ce sont des
  fichiers Markdown créés et complétés par l'utilisateur - Fata se
  contente de les lire, mais ne les modifie pas ;

* un fichier `banque.json` créé au début du projet via la commande
  `init` ; il contient une banque de questions génériques à utiliser
  pour faire avancer la construction de l'histoire fictive ;

* un fichier `questions-posées.json` créé au début du projet via la
  commande `init` et mis à jour automatiquement à chaque utilisation
  de la commande `ask`. Ce fichier trace simplement les questions qui
  ont déjà été posées.

L'outil parse une partie du contenu des fichiers Markdown pour
identifier des focus, des périodes et des mots-clefs :

* les *focus* correspondent aux titres de premier niveau (`#`) dans
  les Markdown ; un focus est typiquement un peuple ou une étendue
  géographique ; chaque Markdown doit contenir exactement un focus,
  défini à la première ligne du fichier ;

* les *périodes* correspondent aux titres de deuxième niveau (`##`)
  dans les Markdown ; ce sont des périodes historiques ;

* les *mots-clefs* sont les mots mis en gras (`**mot**`) dans les
  Markdown. Ils permettent d'identifier des éléments notables.

Via la commande `fata ask`, l'outil croise la banque des questions
génériques et la liste des focus et des périodes pour sélectionner
aléatoirement une question qui n'a pas déjà été posée. Cette question
peut être totalement générique mais, dans la plupart des cas, elle
fera intervenir un focus et / ou une période. Contrairement aux focus
et aux périodes, les mots-clefs ne sont pas utilisés dans les
questions par Fata : ils ne servent qu'à l'utilisateur.

L'utilisateur "répond" à la question en rédigeant directement dans les
Markdown. Il faut toutefois noter qu'aucun contrôle n'est effectué par
Fata, ni sur le fait que les modifications répondent effectivement à
la question, ni sur la cohérence du contenu des
Markdown. L'utilisateur peut tout aussi bien ne pas répondre du tout à
la question : Fata considérera néanmoins la question comme déjà posée,
et ne la reposera plus.

## Remarques

### Chronologie

La chronologie est commune à tous les focus, qui doivent définir
exactement les mêmes périodes, dans le même ordre. On ne peut donc
notamment pas avoir une période qui serait définie dans un focus `A`
mais pas dans un focus `B`.

### Modification des fichiers JSON

L'essentiel de l'utilisation de Fata se traduit par la rédaction des
fichiers Markdown. Toutefois, il est aussi possible de modifier à la
main les fichiers `banque.json` (par exemple pour ajouter ou supprimer
des questions génériques) et `questions-posées.json` (par exemple pour
ajouter une question à laquelle on a incidemment déjà répondu).

### Syntaxe des questions

Le fichier `banque.json` contient une liste de chaînes de caractères :
chaque chaîne de caractères est une question. La question est posée
telle quelle par Fata, à l'exception de deux sous-chaînes de
caractères qui sont remplacées par des données du dossier :

* `{{ focus }}`, qui sera remplacée par un des focus du dossier ;

* `{{ period }}`, qui sera remplacée par une des périodes du dossier.

Une question contient au plus une période et / ou un focus. Cela
signifie que, en l'état, Fata n'est pas en mesure de poser des
questions qui feraient intervenir plusieurs focus et / ou plusieurs
périodes.
