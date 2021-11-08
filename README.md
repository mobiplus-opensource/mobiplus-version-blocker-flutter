## Introdução :globe_with_meridians:

Texto de apresentação da lib.

## Vamos começar :wrench:

### Configuração inicial:

```dart
import 'package:block_version/block_version.dart';

final _appBlocker = AppBlocker.instance;

// 'AppBlockerData' recebe uma versão ou build.
// Caso os 2 sejam informados, a versão terá prioridade.
_appBlocker.block(
  AppBlockerData(
    version: "1.5.0",
  ),
);

// Caso não seja informada uma mensagem, será usado
// um texto padrão: 'Por favor, atualize seu aplicativo!'
_appBlocker.blockScreen(
  onWillPop: () async => false,
  message: Text("Por favor, atualize seu aplicativo!"),
);

_appBlocker.start();
```

### Métodos avançados:

```dart
// Recebe uma lista de versões.
_appBlocker.listOfBlockedVersions(
  [
    AppBlockerData(
      version: "1.1.0",
    ),
    AppBlockerData(
      version: "1.3.0",
    ),
  ],
);

// Recebe uma lista de builds.
_appBlocker.listOfBlockedBuilds(
  [
    AppBlockerData(
      build: "21",
    ),
    AppBlockerData(
      build: "34",
    ),
  ],
);

// Bloqueia versões ou builds maiores que.
_appBlocker.blockBiggerThan(
  AppBlockerData(
    version: "1.0.0",
  ),
);

// Bloqueia versões ou builds menores que.
_appBlocker.blockLessThan(
  AppBlockerData(
    build: "33",
  ),
);

// Bloqueia builds entre.
_appBlocker.blockBuildsBetween([
  AppBlockerData(
    build: "20",
  ),
  AppBlockerData(
    build: "35",
  ),
]);

// Bloqueia versões entre.
_appBlocker.blockVersionsBetween([
  AppBlockerData(
    version: "1.1.0",
  ),
  AppBlockerData(
    version: "1.5.0",
  ),
]);
```

### Widget

- **blockScreen:** Caso não seja informada uma mensagem, será usado um texto padrão: 'Por favor, atualize seu aplicativo!'.

- O parâmetro **onWillPop** tem o valor **() async => false** como padrão.

```dart
_appBlocker.blockScreen(
  onWillPop: () async => false,
  message: Text("Por favor, atualize seu aplicativo!"),
);

_appBlocker.blockScreenBuilder(
  onWillPop: () async => false,
  builder: (context, version, build) => MyWidget(),
);
```

## Contribuindo :cupid:

#421 - issue

## Contribuintes :sparkles:

- [Tiago Silva](https://github.com/tigosante)
- [Wellington Felisberto](https://github.com/WellingtonSilva1992)
