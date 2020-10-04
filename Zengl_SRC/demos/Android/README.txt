RU:
ВНИМАНИЕ! Выбирайте соответствующие библиотеки для нужных архитектур.
В ZenGL включены библиотеки ARMV5 и ARMV6.


Порядок сборки:
- собрать библиотеку используя файл проекта для Lazarus'а, например "01 - Initialization/jni/demo01_linux.lpi"
- *.so - библиотеку скопировать в папку "..libs\armeabi\" - папки проекта "01 - Initialization"
- импортировать в Eclipse (Android Studio) основной каталог проекта - "01 - Initialization"
- запустить дебаг :)

EN:
WARNING! 

Build steps:
- compile library using project file for Lazarus, e.g. "01 - Initialization/jni/demo01_linux.lpi"
- *.so - library copy to folder "..libs\armeabi\" - project "01 - Initialization"
- import main directory of project into Eclipse
- run debug :)


Изменения, примеры можно запустить с NDK версией выше r8e и fpc версии выше 3.0.4.
Для версии FPC 3.0.4 решения я не нашёл, возможно по инструкциям Andru: http://zengl.org/wiki/doku.php?id=compilation:android
Для версий FPC 3.2 и выше инструкции Andru устарели. Создаётся сразу рабочий код под Android.

