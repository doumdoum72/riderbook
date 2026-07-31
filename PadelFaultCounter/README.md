# Compteur de fautes Padel — Apple Watch Series 3

Solution basée sur l'app **Raccourcis** (Shortcuts) native d'iOS/watchOS.
Aucune app à coder/compiler : la Watch Series 3 (watchOS 6 à 8) exécute les
raccourcis directement depuis le poignet (relayés vers l'iPhone à proximité
pour les actions qui le nécessitent, de façon transparente).

Tu vas créer 3 raccourcis dans l'app **Raccourcis** sur ton iPhone (ils se
synchronisent automatiquement sur la montre) :

1. `Faute Padel` — le bouton principal, +1 à chaque appui
2. `Total Fautes` — annonce le nombre de fautes du match en cours
3. `Nouvelle Partie` — remet le compteur à zéro

Le stockage utilise la liste **Rappels** (app Reminders) comme compteur
persistant : chaque faute = un rappel ajouté à une liste dédiée. Pas de
fichier iCloud à gérer, pas d'app tierce, et bonus : tu gardes un historique
horodaté des fautes si tu veux relire le déroulé du match.

---

## Étape 0 — Créer la liste dédiée

1. Ouvre l'app **Rappels**.
2. Crée une nouvelle liste nommée exactement `Fautes Padel`.

---

## Étape 1 — Raccourci "Faute Padel" (le bouton +1)

Dans l'app **Raccourcis** > onglet Raccourcis > `+` (Nouveau raccourci) :

1. Renomme le raccourci `Faute Padel` (icône/couleur au choix, ex. un
   symbole tennis/raquette).
2. Ajoute l'action **Ajouter un nouveau rappel** :
   - Titre : `Faute`
   - Liste : `Fautes Padel`
3. Ajoute l'action **Rechercher des rappels** :
   - Liste : `Fautes Padel`
   - Filtre : `Terminé` est `Non`
4. Ajoute l'action **Compter** (Count) sur le résultat de l'action précédente
   (choisis "Éléments").
5. Ajoute l'action **Énoncer le texte** (Speak Text), avec le texte :
   `Faute numéro [Nombre]` (insère la variable du Compte à la place de
   `[Nombre]`).
   - Optionnel : ajoute aussi **Afficher une notification** avec le même
     texte, pour un retour visuel sur la montre en plus du vocal.

Résultat : chaque exécution ajoute une faute et t'annonce le total à voix
haute — utile en plein match sans avoir à lire l'écran.

---

## Étape 2 — Raccourci "Total Fautes" (bilan en fin de match)

Nouveau raccourci, renommé `Total Fautes` :

1. **Rechercher des rappels** — Liste : `Fautes Padel`, Terminé : Non
2. **Compter** les éléments trouvés
3. **Énoncer le texte** : `Tu as fait [Nombre] fautes ce match`

C'est ce raccourci que tu lances (ou dis à voix haute) à la fin de la
partie pour avoir ton bilan ("3 fautes" ou "17 fautes").

---

## Étape 3 — Raccourci "Nouvelle Partie" (reset)

Nouveau raccourci, renommé `Nouvelle Partie` :

1. **Rechercher des rappels** — Liste : `Fautes Padel`, Terminé : Non
2. **Supprimer les rappels** (sur le résultat de la recherche)
3. **Afficher une notification** : `Compteur remis à zéro`

Lance-le avant chaque nouveau match.

---

## Étape 4 — Accès rapide depuis la montre

Trois façons de déclencher `Faute Padel` en un geste pendant le match,
compatibles Series 3 :

- **Siri** (le plus rapide, mains libres) : « Dis Siri, Faute Padel ».
  La montre vibre et annonce le total sans avoir à lever le poignet vers
  l'écran.
- **Complication sur le cadran** : sur l'iPhone, app **Watch** >
  personnaliser un cadran > ajoute une complication `Raccourcis` réglée sur
  `Faute Padel`. Un tap sur le cadran suffit alors.
- **App Raccourcis sur la montre** : ouvre l'app Raccourcis directement au
  poignet et tape sur `Faute Padel` dans la liste.

Fais pareil pour `Total Fautes` sur une deuxième complication ou via Siri
en fin de match.

---

## Notes

- Les noms d'actions ci-dessus correspondent à l'app Raccourcis en français ;
  si ton iOS est en anglais ce sont respectivement : *Add New Reminder*,
  *Find Reminders*, *Count*, *Speak Text*, *Show Notification*,
  *Delete Reminders*.
- Les actions type Rappels sont relayées automatiquement vers l'iPhone si
  besoin (transparent), donc garde ton iPhone à portée Bluetooth pendant le
  match (typiquement dans ton sac au bord du court).
- Si tu préfères un compteur purement numérique sans passer par les
  Rappels (ex. pas d'iPhone à proximité, tout en local sur la montre), une
  variante possible est de stocker le nombre dans un fichier texte via
  **Obtenir un fichier** / **Enregistrer un fichier** (iCloud Drive) plutôt
  que dans les Rappels — demande si tu veux cette variante détaillée.
