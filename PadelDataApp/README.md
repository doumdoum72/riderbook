# Padel — app iPhone d'analyse de fautes

App SwiftUI **iPhone uniquement** (on abandonne la piste Apple Watch Series
3, incompatible avec les versions récentes d'Xcode/watchOS). Une seule
cible à créer, pas de watchOS, pas de synchro — beaucoup plus simple que la
version précédente.

## Fonctionnalités

- **Onglet Match** : démarre un match (noms d'équipes), puis pendant le
  match trois boutons dédiés — **Ma faute**, **Faute provoquée**, **Faute
  partenaire** — chacun avec son compteur, plus le score par set (+1 jeu
  moi/eux, nouveau set). "Terminer le match" sauvegarde.
- **Onglet Historique** : liste de tous les matchs joués, swipe pour
  supprimer, détail par match (répartition des fautes par catégorie,
  score par set, chronologie horodatée de chaque faute).
- **Onglet Statistiques** : nombre de matchs, moyenne de fautes,
  répartition totale par catégorie, graphique d'évolution dans le temps.

Les données sont sauvegardées localement sur l'iPhone (fichier JSON dans
le dossier Documents de l'app).

## Installation dans Xcode (un seul target, simple)

1. Xcode → **Create New Project** → onglet **iOS** → **App**
2. Product Name : `PadelApp`, Interface : **SwiftUI**, Language : **Swift**
3. Team : ton Apple ID (Xcode Settings > Accounts si besoin de l'ajouter)
4. Enregistre le projet où tu veux
5. Supprime les fichiers par défaut `ContentView.swift` et
   `PadelAppApp.swift` (ou équivalent avec `@main`) générés par Xcode
6. Clic droit sur le groupe du projet → **Add Files to "PadelApp"...** →
   sélectionne **tous** les fichiers `.swift` de ce dossier
   (`PadelDataApp/`) → assure-toi que la case du target `PadelApp` est
   cochée → **Add**
7. Onglet **Signing & Capabilities** du target → coche **Automatically
   manage signing** → Team = ton Apple ID
8. Branche ton iPhone en USB, sélectionne-le comme device cible en haut de
   la fenêtre Xcode (à côté du bouton ▶), puis **Cmd+R**

Pas de réglage de version minimale à bricoler : la valeur par défaut
d'Xcode convient très bien pour un iPhone récent.

**Si iOS bloque le premier lancement** ("développeur non fiable") :
Réglages iPhone → Général → VPN et gestion de l'appareil → fais confiance
à ton Apple ID.

**Compte Apple gratuit** : l'app expire au bout de 7 jours, il suffit de
relancer Cmd+R depuis Xcode pour la réinstaller.

## En cas d'erreur de compilation

Copie-colle le message d'erreur exact (fichier + ligne) et je corrige.
