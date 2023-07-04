RU:
ВНИМАНИЕ! Выбирайте проекты под нужные архитектуры.
В ZenGL включены библиотеки ARMV5, ARMV6, ARMV7A, AARCH64 (ARMV8A), x86, x86_64.

!!!
ВНИМАНИЕ! Если вы хотите компилировать под архитектуры ARMV5 и ARMV6 вы должны отключить дефайн CPUARMV7A в файле настроек zgl_config.cfg.

Для сборки проекта вам необходимо настроить кросскомпилятор FPC под архитектуры Android, которые вы будете использовать.
Так же вам нужна среда разработки Eclipse 2019-го года (более поздние версии в настоящее время не поддерживают разработку под Android).
Настройте среду разработки Eclipse для разработки под Android.
Например так:
https://www.fandroid.info/ustanovka-eclipse-i-podklyuchenie-plagina-android-development-tools-adt-dlya-razrabotki-android-prilozhenij/
Используйте Java 8. Я не нашёл способа собрать проекты с более новыми версиями Java.

Порядок сборки:
- собрать библиотеку используя файл проекта для Lazarus'а, например "01-Initialization/jni/demo01_linux.lpi"
- импортировать в Eclipse (Android Studio) основной каталог проекта - "01-Initialization"
- запустить дебаг :)



EN:
WARNING! Choose projects for the desired architectures.
ZenGL includes ARMV5, ARMV6, ARMV7A, AARCH64 (ARMV8A), x86, x86_64 libraries.

!!!
ATTENTION! If you want to compile for ARMV5 and ARMV6 architectures you must disable define CPUARMV7A in the zgl_config.cfg configuration file.

To build the project, you need to configure the FPC cross compiler for the Android architectures that you will use.
You also need the 2019 Eclipse development environment (later versions do not currently support Android development).
Set up the Eclipse development environment for Android development.
For example like this:
https://www.tutorialspoint.com/android/android_eclipse.htm
Use Java 8. I haven't found a way to build projects with newer versions of Java.

Build steps:
- compile library using project file for Lazarus, e.g. "01-Initialization/jni/demo01_linux.lpi"
- import main directory of project into Eclipse
- run debug :)

