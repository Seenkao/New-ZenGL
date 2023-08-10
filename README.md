# ZenGL version 4.0 + MacOS Cocoa - beta version + Green Engine v1.0

**Внимание!!!** Данная версия претерпела много изменений. Исключён код для MacOS-carbon. Собраны библиотеки Ogg, Vorbis, Theora, LibZip для Android ARM32/ARM64/X86/X86_64. Могут быть проблемы с запуском на MacOS-Cocoa, это будет исправляться. Вы можете использовать версию ZenGL 3.30 она наиболее стабильна, но не поддерживает обновлений для Android.

**Attention!!!** This version has undergone many changes. Excluded code for MacOS-carbon. Compiled and added libraries Ogg, Vorbis, Theora, LibZip for Android ARM32/ARM64/X86/X86_64. There may be problems with running on MacOS-Cocoa, this will be fixed. You can use ZenGL version 3.30, it is the most stable version but does not support Android updates.


[Eng](#English)  
1.
 [About](#About)  
2.
 [Features](#Features)  
3.
 [Green Engine](#GEEng) 

[Rus](#Russian)  
1.
 [О ZenGL](#AboutRus)  
2.
 [Возможности библиотеки](#FeaturesRus)  
3.
 [Green Engine](#GERus)  

<a name="English"></a>Eng:
-------------

<a name="About"></a>**About:**  
[zengl 3.12](https://github.com/skalogryz/zengl) - version that also supports iOS.

[google arhive](https://code.google.com/archive/p/zengl/)

**ZenGL** - it is a library that creates window context for working with OpenGL on different platforms.

**Important to know!** You don't need to know OpenGL to use this library. The __ZenGL__ library provides [many library features](#FeaturesRus) for any programmer who knows Pascal and does not know OpenGL.

**Development environment**
- Lazarus/FreePascal
- Delphi

**Supported platforms for Lazarus/FreePascal:**
- Windows 32/64
- Linux 32/64
- Android - ARM32 (v5, v6, v7a)/ARM64(v8a)/x86/x86_64
- MacOS Cocoa - beta version

**Supported Platforms for Delphi:**
- Windows 32 (some demos will probably work with Windows 64 too, but certainly not all)

See the changes in the __Update_ZenGL.txt__ file.  Sorry, the information is only in Russian. :(

Important update: This version has updated OpeGL to the latest version as per end of 2021. All extensions have also been updated. Files: __zgl_pasOpenGL.pas__, __zgl_GLU.pas__, __zgl_GLX_WGL.pas__, __zgl_gltypeconst.pas__, __GLdefine.cfg__.

Ways to work with 3D were not implemented. You will need to do this manually or set __oglMode__ to 3. I haven't tested it! You can rewrite the procedure __Set3DMode(FOVY: Single = 45);__ and set all the parameters yourself.

Clicking on the image will take you to the video. Where I redo the 3rd demo. At the end of the video, it shows that you can make multiple input fields.

[![demo3 remake](https://github.com/Seenkao/New-ZenGL/blob/ZenGL_4_0/Zengl_SRC/bin/data/back04.jpg)](https://youtu.be/qb8hxilAI_I)

<a name="Features"></a>**Features:**  
* __Main__  
   can be used as so/dll/dylib or statically compiled with your application (in this version only static compilation)  
   rendering to own or any other prepared window  
   logging  
   resource loading from files, memory and zip archives  
   multithreaded resource loading  
   easy way to add support for new resource format  
 * __Configuration of__  
   antialiasing, screen resolution, refresh rate and vertical synchronization  
   aspect correction  
   title, position and size of window  
   cursor visibility in window space  
 * __Input__  
   handling of keyboard, mouse and joystick input  
   handling of Unicode text input  
   possibility to restrict the input to the Latin alphabet  
 * __Textures__  
   supports __tga__, __png__, __jpg__ and __pvr__  
   correct work with NPOT textures  
   control the filter parameters  
   masking  
   render targets for rendering into texture  
 * __Text__  
   textured Unicode font  
   rendering UTF-8 text  
   rendering text with alignment and other options like size, color and count of symbols  
 * __2D subsystem__  
   batch render for high-speed rendering  
   rendering different primitives  
   sprite engine  
   rendering static and animated sprites and tiles  
   rendering distortion grid  
   rendering sprites with new texture coordinates (with the pixel dimension and the usual 0..1)  
   control the blend mode and color mix mode  
   control the color and alpha of vertices of sprites and primitives  
   additional sprite transformations (flipping, zooming, vertices offset)  
   fast clipping of invisible sprites  
   2D camera with ability to zoom and rotate the scene  
 * __Sound__  
   works through OpenAL or DirectSound; depends on configuration or OS  
   correct work without soundcard  
   supports __wav__ and __ogg__ as sound sample formats  
   playing audio files in separate thread  
   control volume and playback speed  
   moving sound sources in 3D space  
 * __Video__  
   decoding video frames into texture  
   supports __theora__ codec in __ogv__ container  
 * __Math__  
   basic set of additional math functions  
   triangulation functions  
   basic set of collision functions  
 * __Additional__  
   reading and writing INI files  
   functions for working with files and memory  

***

<a name="GEEng"></a>**Green Engine:**

**GE** is a library that works on top of ZenGL features. Currently, it includes an input field with additional functions for it, and a module for working with color, where there are standard colors and you can set your own.

***
Communication: M12Mirrel@yandex.ru  
You can also contact me on the Lazarus forums and express your wishes and shortcomings.

You can support through Sberbank:
2202200951985520

The original source code is at [GitHub](https://github.com/Seenkao/New-ZenGL) other sites may have a back branch.

Please write about the errors found in the process of working with ZenGL. )))

****

<a name="Russian"></a>Rus:
-------------

<a name="AboutRus"></a>**О ZenGL:**  
[zengl 3.12](https://github.com/skalogryz/zengl) - версия которая так же поддерживает iOS.

[архив гугла](https://code.google.com/archive/p/zengl/)

**ZenGL** - это бибилотека создающая контекст окна для работы с OpenGL на разных платформах.

**Важно знать!** Для использования данной библиотеки, вам не обязательно знать OpenGL. Библиотека __ZenGL__ предоставляет [много возможностей библиотеки](#FeaturesRus) для любого программиста знающего паскаль и не знающего OpenGL.  

**Среда разработки**
- Lazarus/FreePascal
- Delphi

**Поддерживаемые платформы для Lazarus/FreePascal:**
- Windows 32/64
- Linux 32/64
- Android - ARM32 (v5, v6, v7a)/ARM64(v8a)/x86/x86_64
- MacOS Cocoa - beta version

**Поддерживаемые платформы для Delphi:**
- Windows 32 (вероятно некоторые демо-версии будут работать и с Windows 64, но точно не все)

***
Изменения смотрите в файле __Update_ZenGL.txt__.

Важное обновление: в данной версии обновлён OpeGL до последней версии согласно конца 2021 года. Так же обновлены все расширения. Файлы: __zgl_pasOpenGL.pas__, __zgl_GLU.pas__, __zgl_GLX_WGL.pas__, __zgl_gltypeconst.pas__, __GLdefine.cfg__.

Способов работы с 3D не реализовывалось. Вам надо будет делать это вручную или __oglMode__ приравнять 3. Я не проверял работоспособность! Вы можете переписать процедуру __Set3DMode(FOVY: Single = 45);__ и задать все параметры самим.

при нажатии на картинку перейдёте на видео. Где я переделываю 3-ю демо версию. В конце видео показано, что можно делать несколько полей ввода.

[![переделка demo3](https://github.com/Seenkao/New-ZenGL/blob/ZenGL_4_0/Zengl_SRC/bin/data/back04.jpg)](https://youtu.be/qb8hxilAI_I)

<a name="FeaturesRus"></a>**Возможности библиотеки:**  
 * __Основные__  
   библиотека может быть скомпилирована статически к проекту, или использоваться, как динамическая библиотека (в данной версии только статическая компиляция)  
   рендеринг как в собственное, так и в заранее подготовленное окно (LCL, VCL)  
   журнал событий  
   загрузка ресурсов из файлов, памяти и zip архивов  
   многопоточная загрузка ресурсов  
   возможность расширить количество поддерживаемых форматов данных  
 * __Возможности настройки графики__  
   Сглаживание (antialiasing), разрешение и частоту обновления экрана (screen resolution, refresh rate) а так же контролировать вертикальную синхронизацию (v-sync)  
   коррекция пропорций выводимого изображения относительно заданных размеров  
   управление заголовком и размером окна, наличие автоматического центрирования  
   управление видимостью курсора в пределах окна  
 * __Устройства ввода__  
   обработка событий клавиатуры, мыши и джойстика  
   ввод Unicode символов  
   возможность ограничить ввод только латинской раскладкой  
 * __Вывод Текстур__  
   поддержка форматов __tga__, __png__, __jpg__ и __pvr__  
   поддержка текстур размером не кратным 2 (Non Power Of Two)  
   управление параметрами фильтрации  
   работа с масками  
   *render targets* отрисовка в текстуры  
 * __Вывод текста__  
   реализация Unicode шрифты на основе текстур  
   вывод UTF-8 текста  
   управление отступами, размером, цветом вершин и количеством символов в тексте  
 * __2D подсистема__  
   *batch render* для повышения производительности рендеринга  
   рендеринг основных видов примитивов  
   спрайтовый движок  
   вывод статических и анимированных спрайтов и тайлов  
   рендеринг трансформирующейся сетки  
   рендеринг спрайтов с ручным указанием текстурных координат(с пиксельной размерностью и обычным 0..1)  
   управление режимом блендинга и смешивания цвета  
   возможность назначения цвета и альфы отдельным вершинам спрайтов и примитивов  
   дополнительные трансформации спрайтов(зеркальное отражения, увеличение, смещение вершин)  
   быстрое отсечение спрайтов выходящих за пределы видимости  
   наличие 2D камеры с возможностью увеличения и поворота содержимого сцены  
 * __Звук__  
   вывод звука с помощью библиотек OpenAL или DirectSound (зависит от настроек проекта и операционной системы)  
   возможность правильной работы, даже при отсутствии звуковой карты  
   поддержка форматов __wav__ и __ogg__  
   потоковое воспроизведение аудио-файлов  
   контроль за громкостью звука и темпом воспроизведения  
   трехмерное позиционирование источника звука в пространстве  
 * __Видео__  
   декодирование видео заставок в текстуры  
   поддержка кодека __theora__ в формате __ogv__  
 * __Математический вычисление__  
   базовый набор вспомогательных математических функций  
   необходимый набор функций для триангуляции  
   простейшие функции проверки столкновений  
 * __Доплнительно__  
   чтение и запись INI файлов  
   дополнительные функции для работы с файлами и памятью  

***

<a name="GERus"></a>**Green Engine:**

**GE** - это библиотека которая работает поверх возможностей ZenGL. В данное время она включает в себя поле ввода с дополнительными функциями для него, и модуль для работы с цветом, где есть стандартные цвета и можно задавать свои.

***
Связь: M12Mirrel@yandex.ru  
Так же можно связаться со мной на форумах Lazarus и высказать пожелания и недоработки.

Поддержать можно через сбер:
2202200951985520

Оригинальный исходный код находится на [GitHub](https://github.com/Seenkao/New-ZenGL) на других сайтах может отстающая ветка.

Просьба писать об ошибках выявленных в процессе работы с ZenGL. )))
