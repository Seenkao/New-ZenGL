RU:
ВНИМАНИЕ! Выбирайте соответствующие библиотеки для нужных архитектур.
В ZenGL включены библиотеки ARMV5 и ARMV6. Другие архитектуры в процессе.

!!! если демки не компилируются, уберите все пробелы и скобки из путей до проекта.

Порядок сборки:
- собрать библиотеку используя файл проекта для Lazarus'а, например "01-Initialization/jni/demo01_linux.lpi"
- *.so - библиотеку скопировать в папку "..libs\armeabi\" - папки проекта "01-Initialization"
- импортировать в Eclipse (Android Studio) основной каталог проекта - "01-Initialization"
- запустить дебаг :)

Изменения: примеры можно запустить с NDK версией выше r8e и fpc версии выше 3.0.4.
Для версии FPC 3.0.4 решения я не нашёл, возможно по инструкциям Andru: http://zengl.org/wiki/doku.php?id=compilation:android
Для версий FPC 3.2 и выше инструкции Andru на сайте устарели. Создаётся сразу рабочий код под Android.

EN:
WARNING! Choose the appropriate libraries for the required architectures.
ZenGL includes the ARMV5 and ARMV6 libraries. Other architectures in progress.

!!! if demos don't compile, remove all spaces and parentheses from project paths.

Build steps:
- compile library using project file for Lazarus, e.g. "01-Initialization/jni/demo01_linux.lpi"
- *.so - library copy to folder "..libs\armeabi\" - project "01-Initialization"
- import main directory of project into Eclipse
- run debug :)

Changes: examples can be run with NDK version above r8e and fpc version above 3.0.4.
For FPC version 3.0.4, I did not find a solution, perhaps according to Andru's instructions: http://zengl.org/wiki/doku.php?id=compilation:android
For FPC versions 3.2 and higher, Andru's instructions on the website are outdated. A working code for Android is created immediately.
