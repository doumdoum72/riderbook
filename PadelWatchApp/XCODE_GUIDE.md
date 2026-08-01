# Guide Xcode complet — débutant total

Ce guide part du principe que tu n'as jamais utilisé Xcode. Chaque étape
explique où cliquer concrètement.

---

## Partie A — Récupérer les fichiers du projet sur ton Mac

1. Ouvre l'app **Terminal** (Cmd+Espace, tape `Terminal`, Entrée)
2. Colle cette commande et appuie sur Entrée :
   ```
   cd ~/Desktop && git clone https://github.com/doumdoum72/riderbook.git
   ```
3. Si on te demande de te connecter à GitHub, suis les instructions à l'écran
4. Une fois terminé, tu as un dossier `riderbook` sur ton Bureau, avec dedans
   `PadelWatchApp/` contenant les fichiers Swift dont on va se servir

---

## Partie B — Créer le projet iOS dans Xcode

1. Ouvre **Xcode** (Launchpad ou Spotlight)
2. Sur l'écran d'accueil, clique **Create New Project...** (ou menu **File
   > New > Project...** si Xcode est déjà ouvert sur un autre projet)
3. Une fenêtre avec des icônes de plateformes s'affiche : clique l'onglet
   **iOS** en haut, puis l'icône **App**, puis **Next** (bouton bleu en bas
   à droite)
4. Formulaire à remplir :
   - **Product Name** : `PadelApp`
   - **Team** : sélectionne ton nom / Apple ID (si rien n'apparaît, voir
     encadré ci-dessous)
   - **Interface** : `SwiftUI`
   - **Language** : `Swift`
   - Décoche "Use Core Data" et "Include Tests" si cochés
5. Clique **Next**, puis choisis où enregistrer : navigue jusqu'à
   `Desktop/riderbook/` et clique **Create**

> **Pas de "Team" disponible ?** Menu Xcode **Settings...** (ou
> **Preferences...**) → onglet **Accounts** → bouton **+** en bas à gauche →
> **Apple ID** → connecte-toi avec ton identifiant Apple habituel (celui de
> ton iPhone). Un compte gratuit suffit.

Xcode ouvre alors la fenêtre principale du projet. Tu verras à gauche une
colonne (le **Navigator**) listant les fichiers, au centre l'éditeur de
code, et en haut une barre d'outils avec un bouton **▶** (Run/Lancer).

---

## Partie C — Ajouter la cible Apple Watch

1. Menu **File > New > Target...**
2. Onglet **watchOS** en haut → sélectionne **Watch App** → **Next**
3. **Product Name** : `PadelApp Watch App`
4. **Embed in Companion Application** : choisis `PadelApp` dans la liste
5. Décoche "Include Notification Scene" si proposé → **Finish**
6. Une popup demande d'activer un nouveau "scheme" (schéma de build) →
   clique **Activate**

Tu as maintenant deux cibles ("targets") dans ton projet, visibles en haut
de la colonne de gauche si tu cliques sur l'icône bleue du projet
(`PadelApp`, tout en haut de la liste) : `PadelApp` (iPhone) et
`PadelApp Watch App` (montre).

---

## Partie D — Régler la version minimale de watchOS (important !)

Ta Apple Watch Series 3 ne peut pas dépasser watchOS 8.x. Par défaut Xcode
vise la toute dernière version, ce qui empêcherait l'installation.

1. Clique sur l'icône bleue du projet **PadelApp** tout en haut de la
   colonne de gauche
2. Dans le panneau central, une liste de "TARGETS" apparaît à gauche du
   panneau (pas la colonne de navigation principale, un sous-panneau) :
   sélectionne **PadelApp Watch App**
3. Onglet **General** (en haut du panneau central)
4. Cherche la section **Minimum Deployments** → règle **watchOS** sur
   **8.0** (utilise le menu déroulant/champ, tape ou sélectionne 8.0)

---

## Partie E — Supprimer les fichiers par défaut

Xcode a créé automatiquement quelques fichiers dans chaque cible qu'il faut
remplacer par les miens.

1. Dans la colonne de gauche (Navigator), déplie le groupe **PadelApp**
   (dossier avec le nom de l'app iPhone)
2. Repère un fichier `PadelAppApp.swift` et `ContentView.swift` → clic droit
   sur chacun → **Delete** → choisis **Move to Trash**
3. Déplie le groupe **PadelApp Watch App**
4. Repère le fichier avec `@main` (souvent nommé
   `PadelApp_Watch_AppApp.swift`) et son `ContentView.swift` → même
   suppression (Move to Trash)

---

## Partie F — Ajouter les fichiers du projet

1. Dans le Finder, ouvre `Desktop/riderbook/PadelWatchApp/`
2. Retour dans Xcode : clic droit sur le groupe **PadelApp** (celui de
   l'iPhone) dans le Navigator → **Add Files to "PadelApp"...**
3. Dans la fenêtre qui s'ouvre, navigue jusqu'à `PadelWatchApp/Shared/` et
   sélectionne les 3 fichiers (`Models.swift`, `MatchStore.swift`,
   `ConnectivityManager.swift`)
4. **Avant de cliquer Add**, en bas de la fenêtre il y a une section
   "Add to targets" avec des cases à cocher pour chaque target : **coche
   les deux** (`PadelApp` ET `PadelApp Watch App`)
5. Clique **Add**
6. Refais la même manipulation (clic droit sur `PadelApp` > Add Files) pour
   le dossier `PadelWatchApp/iOSApp/` (tous les fichiers) — cette fois
   **coche uniquement `PadelApp`** (pas la Watch App)
7. Clic droit sur le groupe **PadelApp Watch App** → **Add Files to
   "PadelApp"...** → sélectionne tous les fichiers de
   `PadelWatchApp/WatchApp/` — coche uniquement **`PadelApp Watch App`**

**Tableau récapitulatif :**

| Fichiers | Target PadelApp (iPhone) | Target PadelApp Watch App |
|---|---|---|
| `Shared/*.swift` | ✅ | ✅ |
| `iOSApp/*.swift` | ✅ | ❌ |
| `WatchApp/*.swift` | ❌ | ✅ |

Si tu t'es trompé quelque part : clique sur le fichier dans le Navigator,
ouvre le panneau de droite (icône du classeur, ou Cmd+Option+1), section
**Target Membership**, coche/décoche les bonnes cases.

---

## Partie G — Signer l'app avec ton Apple ID

1. Clique l'icône bleue du projet **PadelApp** → sélectionne le target
   **PadelApp** dans la liste
2. Onglet **Signing & Capabilities**
3. Coche **Automatically manage signing** si pas déjà coché
4. **Team** : sélectionne ton Apple ID
5. Refais pareil pour le target **PadelApp Watch App** (même onglet, même
   réglages)

Si Xcode affiche une erreur de "Bundle Identifier" en conflit, ajoute
quelque chose d'unique, ex. `com.tonprenom.padelapp` dans le champ **Bundle
Identifier** (pour les deux targets, en gardant le suffixe `.watchkitapp`
généré automatiquement pour la montre).

---

## Partie H — Compiler et installer

1. Branche ton iPhone au Mac en USB (ou assure-toi qu'il est sur le même
   Wi-Fi si tu as déjà configuré le déploiement sans fil)
2. En haut de la fenêtre Xcode, à côté du bouton ▶, il y a un menu déroulant
   indiquant le "scheme" et l'appareil cible — clique dessus
3. Choisis le scheme **PadelApp**, puis ton iPhone dans la liste des
   appareils
4. Clique **▶** (ou Cmd+R) → Xcode compile et installe l'app sur ton iPhone
5. Refais pareil en choisissant le scheme **PadelApp Watch App** et ta
   montre comme cible, puis **▶**

**Premier lancement bloqué ("développeur non fiable") :**
- Sur l'iPhone : **Réglages > Général > VPN et gestion de l'appareil** →
  fais confiance à ton Apple ID
- Sur la montre : **Réglages > Général > VPN et gestion de l'appareil**
  (si présent), sinon ça suit automatiquement la confiance de l'iPhone

**Rappel compte gratuit :** l'app installée expire au bout de 7 jours, il
faudra refaire Cmd+R depuis Xcode pour la réinstaller (le compte payant à
99$/an lève cette limite, pas nécessaire pour un usage perso).

---

## En cas d'erreur de compilation

Xcode affiche les erreurs dans le panneau de gauche (icône ⚠️ rouge) ou en
bas de l'écran. Copie-colle le message d'erreur exact (et le nom du
fichier/ligne concernée) et montre-le moi, je corrige le code en
conséquence.

---

## Fonctionnement de l'app (une fois installée)

Sur la montre : "Nouveau match" → 3 boutons distincts pendant le match —
**Ma faute**, **Faute provoquée**, **Faute partenaire** — chacun avec son
propre compteur affiché à côté, plus le total en haut. "Terminer le match"
sauvegarde et envoie vers l'iPhone.

Sur l'iPhone : onglet Historique (détail par match avec répartition par
catégorie et chronologie), onglet Statistiques (totaux et moyenne, par
catégorie, + graphique d'évolution).
