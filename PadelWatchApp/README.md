# Padel — app native Apple Watch + iPhone

App SwiftUI complète : compteur de fautes et score en direct sur la montre,
historique et statistiques sur l'iPhone. Les matchs terminés sur la montre
sont envoyés automatiquement à l'iPhone (WatchConnectivity) — la montre
reste utilisable seule si l'iPhone n'est pas à proximité.

**Important : je n'ai pas pu compiler/tester ce code (pas de Mac/Xcode dans
mon environnement).** Le code suit des patterns SwiftUI/WatchConnectivity
standards, mais si Xcode remonte une erreur de compilation, montre-la moi et
je corrige.

---

## Pourquoi pas de `.xcodeproj` fourni

Les fichiers `.xcodeproj` sont fragiles à générer à la main (IDs internes,
phases de build) et risquent de ne pas s'ouvrir correctement. Il vaut mieux
laisser Xcode créer le projet (ça prend 2 minutes), puis y copier les
fichiers Swift ci-dessous.

## ⚠️ Point critique : cible de déploiement

**Ta Apple Watch Series 3 plafonne à watchOS 8.x** (pas d'upgrade possible
au-delà). Par défaut, Xcode propose la dernière version de watchOS comme
cible minimale — si tu laisses ça tel quel, l'app ne s'installera pas sur ta
montre. Il faut donc **abaisser manuellement le "Minimum Deployments" du
target Watch App à watchOS 8.0** (voir étape 3 ci-dessous).

---

## Étape 1 — Créer le projet iOS

1. Xcode → **File > New > Project**
2. Onglet **iOS** → **App** → Next
3. Product Name : `PadelApp` — Interface : **SwiftUI** — Language : **Swift**
4. Décoche "Use Core Data" et "Include Tests" (pas nécessaires)
5. Enregistre le projet où tu veux sur ton Mac (ex. après avoir cloné ce
   repo, à côté du dossier `PadelWatchApp/`)

## Étape 2 — Ajouter la cible Watch App

1. Menu **File > New > Target...**
2. Onglet **watchOS** → **Watch App** → Next
3. Product Name : `PadelApp Watch App`
4. **Embed in Companion Application** : sélectionne `PadelApp` (l'app iOS
   créée à l'étape 1)
5. Décoche "Include Notification Scene" si proposé

Xcode crée alors deux targets dans le même projet : `PadelApp` (iPhone) et
`PadelApp Watch App` (montre), avec des fichiers par défaut
(`ContentView.swift`, un fichier `...App.swift` avec `@main`, etc.) que tu
vas remplacer.

## Étape 3 — Fixer la cible de déploiement watchOS

1. Sélectionne le projet dans le navigateur (icône bleue tout en haut)
2. Sélectionne le target **PadelApp Watch App**
3. Onglet **General** → section **Minimum Deployments** → règle **watchOS**
   sur **8.0** (ou plus bas si proposé, ex. 7.0 — plus bas = plus sûr pour
   compatibilité Series 3)

## Étape 4 — Supprimer les fichiers par défaut générés par Xcode

Dans chaque target, Xcode a créé un fichier `@main` et un `ContentView.swift`
par défaut. Supprime-les (clic droit > Delete > "Move to Trash") — on les
remplace par les fichiers fournis ci-dessous :
- Dans le groupe **PadelApp** (iPhone) : supprime le `PadelAppApp.swift` et
  `ContentView.swift` générés
- Dans le groupe **PadelApp Watch App** : supprime le fichier `@main`
  généré (souvent `PadelApp_Watch_AppApp.swift`) et son `ContentView.swift`

## Étape 5 — Copier les fichiers Swift fournis

Dans le Finder, copie (ou clone le repo puis copie) le contenu de ce dossier
`PadelWatchApp/` dans ton projet Xcode. Puis, dans Xcode, clic droit sur
chaque groupe cible → **Add Files to "PadelApp"...** et ajoute les bons
fichiers, **en cochant les bonnes cases de "Target Membership"** :

| Fichier | Target iPhone (`PadelApp`) | Target Watch (`PadelApp Watch App`) |
|---|---|---|
| `Shared/Models.swift` | ✅ | ✅ |
| `Shared/MatchStore.swift` | ✅ | ✅ |
| `Shared/ConnectivityManager.swift` | ✅ | ✅ |
| `WatchApp/*.swift` (tous) | ❌ | ✅ |
| `iOSApp/*.swift` (tous) | ✅ | ❌ |

Astuce : après avoir ajouté un fichier, tu peux vérifier/corriger son
"Target Membership" dans le panneau de droite (File Inspector, ⌥⌘1).

Les fichiers `WatchApp/PadelWatchAppMain.swift` et
`iOSApp/PadelAppMain.swift` contiennent chacun un `@main` — c'est normal,
un par target, ils ne se voient pas entre eux (chaque target compile
indépendamment).

## Étape 6 — Compiler et installer

1. Branche ta montre en charge à côté de l'iPhone (ou assure-toi qu'elle est
   connectée en Bluetooth), et connecte l'iPhone au Mac en USB (ou même
   réseau Wi-Fi si déploiement sans fil déjà configuré)
2. En haut de Xcode, choisis le schéma **PadelApp Watch App** et ton Apple
   Watch comme device cible
3. **Cmd+R** pour compiler et installer sur la montre
4. Fais pareil avec le schéma **PadelApp** vers ton iPhone

Avec un simple identifiant Apple gratuit (Settings Xcode > Accounts), pas
besoin de payer le programme développeur pour installer sur tes propres
appareils. Seule limite : l'app expire au bout de 7 jours et il faudra la
réinstaller depuis Xcode (le compte payant à 99$/an lève cette limite).

## Étape 7 — Autoriser l'app sur l'iPhone/la Watch

Au premier lancement, iOS peut bloquer l'app ("développeur non fiable") :
**Réglages > Général > VPN et gestion de l'appareil** → fais confiance à ton
identifiant Apple.

---

## Fonctionnement de l'app

- **Montre** : écran d'accueil → "Nouveau match" → écran de match avec
  bouton "Faute +1" (et annulation de la dernière faute), score par set
  (+1 jeu pour moi / pour eux, nouveau set), "Terminer le match" pour
  sauvegarder. "Historique" liste les matchs déjà joués.
- **iPhone** : onglet Historique (liste + détail par match, chronologie des
  fautes), onglet Statistiques (nombre de matchs, moyenne de fautes,
  graphique d'évolution dans le temps).
- **Synchro** : à la fin d'un match sur la montre, il est automatiquement
  poussé vers l'iPhone si à portée (sinon synchro dès que possible).

## Pistes pour la suite (hors v1)

- Fiches joueurs dédiées (au lieu de juste taper des noms d'équipe en texte)
  avec stats par joueur
- Types de fautes détaillés (double faute, sortie, filet...) plutôt qu'un
  compteur générique
- Score détaillé point par point (15/30/40/avantage) au lieu de juste les
  jeux
