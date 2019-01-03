# Homero 2019

Contribution à https://twitter.com/Homero2019_ avec le premier chant de l'Iliade dans la traduction de Paul Mazon aux Belles-Lettres.

Plus de détails [sur mon blog](https://abailly.github.io/posts/homero2019.html).

# Build

Ce projet utilise [stack](http://haskellstack.org) et une version 8.6.1 de GHC:

```
$ cd iliade && stack install
```

# Run

En supposant que `~/.local/bin` est dans le `PATH`, pour générer un tweet sans l'envoyer:

```
$ cat chant1 | iliade 1
Mais voici que Nestor se lève, Nestor au doux langage, l’orateur sonore de Pylos. De sa bouche ses accents coulent plus doux que le miel. Il a déjà vu passer deux générations de mortels, qui jadis, avec lui, sont nées et ont grandi dans Pylos la divine, #homero2019
```

Pour envoyer 10 tweets (voir [tweet-hs](https://hackage.haskell.org/package/tweet-hs)) pour la configuration nécessaire du fichier `.cred.toml`:

```
$ $ cat chant1 | iliade 10 Y
tandis qu’en son âme et son cœur il remue ces pensées et qu’il tire déjà du fourreau sa grande épée, Athéné vient du ciel. C’est Héré qui la dépêche, la  déesse aux bras blancs, qui en son cœur les aime et les protège également tous deux. #homero2019
Arnaud (dr_c0d3):
    tandis qu’en son âme et son cœur il remue ces pensées et qu’il tire déjà du fourreau sa grande épée, Athéné vient d… https://t.co/XLKNJRhMQq
    💜 0   0  1080875339058950145


Elle s’arrête derrière le Péléide et lui met la main sur ses blonds cheveux – visible pour lui seul : nul autre ne la voit. Achille est saisi de stupeur ; il se retourne et aussitôt reconnaît Pallas Athéné. Une lueur terrible s’allume dans ses yeux, et, #homero2019
Arnaud (dr_c0d3):
    Elle s’arrête derrière le Péléide et lui met la main sur ses blonds cheveux – visible pour lui seul : nul autre ne… https://t.co/E4k2dV2k8E
    💜 0   0  1080875467283066880
```

Chaque exécution met à jour un fichier `.break` dans le répertoire courant qui stocke l'index à partir duquel lire pour générer le prochain tweet.
