# Примеры сборки кастомного ISO образа с NixOS

В этом репозитории представлены примеры для видео про создание кастомного ISO образа: [original-video](https://www.youtube.com/watch?v=Rd7JIzm1SNc)

[![original-video](https://img.youtube.com/vi/Rd7JIzm1SNc/0.jpg)](https://www.youtube.com/watch?v=Rd7JIzm1SNc)

## Как собрать любой из примеров?

Клонируем репозиторий и переходим в него:
```
git clone https://github.com/sysraccoon/nixos-custom-iso-examples.git
cd nixos-custom-iso-examples
```

Запускаем nix-shell/dev-shell в котором будет доступна команда `just`:
```
nix-shell # или nix develop
```

Выводим список доступных вариантов:
```
just --list
```
```
Available recipes:
    add-home-manager-channel
    build-01-simple-live-non-flaked
    build-02-simple-live-flaked
    build-03-home-live-non-flaked
    build-04-home-live-flaked
    build-05-home-broken-live-flaked
    build-nixos-generators-01-simple-live-non-flaked
    build-nixos-generators-02-simple-live-flaked
    build-nixos-generators-03-home-live-non-flaked
    build-nixos-generators-04-home-live-flaked
    build-nixos-generators-05-home-broken-live-flaked
    list-recipes
    remove-home-manager-channel
```

> [!WARNING]  
> Если вы используете `nix-shell` и у вас выводится такая ошибка:
> ```
> error: Expected '@', comment, end of file, end of line, or identifier, but found '['
>    |
> 29 | [private]
>    | ^
> ```
> Попробуйте воспользоваться `nix develop`, так как требуется более новая версия `just`

Теперь можно собрать любой из перечисленных вариантов используя команду (подставляя нужный recipe-name)
```
just recipe-name
```

Например так для сборки 2 примера с использованием `nix build`.
```
just build-02-simple-live-flaked
```

Результат будет доступен в `./result/iso`:
```
ls result/iso
```
```
nixos-24.05.20240630.7dca152-x86_64-linux.iso
```

## Как сделать тоже самое без just?

Сборка без флейка и nixos-generators (вместо `{{nixos-config}}` подставляем свой файл конфигурации):
```
nix-build "<nixpkgs/nixos>" -A config.system.build.isoImage -I nixos-config={{nixos-config}}
```

Сборка без флейка, но с nixos-generators:
```
nix run nixpkgs#nixos-generators -- --format iso --configuration {{nixos-config}} -o result
```

Сборка с флейком, но без nixos-generators (вместо `{{flake-directory}}` подставляем директорию в котором находится `flake.nix`, вместо `{{configuration-name}}` название конфигурации объявленной в `{{flake-directory}}/flake.nix#nixosConfigurations`)
```
nix build {{flake-directory}}#nixosConfigurations.{{configuration-name}}.config.system.build.isoImage
```

Сборка с флейком и nixos-generators:
```
nix run nixpkgs#nixos-generators -- --format iso --flake {{flake-directory}}#{{configuration-name}} -o result
```

## Дополнительные ресурсы про сборку NixOS образов

- nixos-generators github: [link](https://github.com/nix-community/nixos-generators)
- nixpkgs installation modules: [link](https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/cd-dvd)
- nixos manual (building ISO image section): [link](https://nixos.org/manual/nixos/stable/#sec-building-image)
- vimjoyer youtube video: [link](https://www.youtube.com/watch?v=-G8mN6HJSZE&ab_channel=Vimjoyer)
