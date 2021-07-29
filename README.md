# ZenGL version 3.28 + MacOS Cocoa - beta version + Green Engine v1.0

[Eng](#English)  
[Rus](#Russian)

<a name="English"></a>Eng:
-------------

[zengl](https://zengl.org) - the original site of the library's creator.

**ZenGL** - it is a library that creates window context for working with OpenGL on different platforms.

**Development environment**
- Lazarus/FreePascal
- Delphi

**Supported platforms for Lazarus/FreePascal:**
- Windows 32/64
- Linux 32/64
- Android
- MacOS Cocoa - beta version
- *MacOS Carbon (not tested, use version 3.12 if won't work)*

**Supported Platforms for Delphi:**
- Windows 32 (some demos will probably work with Windows 64 too, but certainly not all)

[zengl for iOS](https://github.com/skalogryz/zengl) - version that supports iOS (I have not verified).

****

<a name="Russian"></a>Rus:
-------------

[zengl](https://zengl.org) - изначальный сайт создателя библиотеки.

**ZenGL** - это бибилотека создающая контекст окна для работы с OpenGL на разных платформах.

**Среда разработки**
- Lazarus/FreePascal
- Delphi

**Поддерживаемые платформы для Lazarus/FreePascal:**
- Windows 32/64
- Linux 32/64
- Android
- MacOS Cocoa - beta version
- *MacOS Carbon (не проверено используйте версию 3.12 если не будет работать)*

**Поддерживаемые платформы для Delphi:**
- Windows 32 (вероятно некоторые демо-версии будут работать и с Windows 64, но точно не все)

[zengl for iOS](https://github.com/skalogryz/zengl) - версия которая поддерживает iOS (мною не проверено).

***
В данной версии:

- Добавлена библиотека Green Engine собственной разработки. Это вроде как дополнительное API для библиотеки ZenGL. Разрабатывалась ранее и клавиатура из Green Engine была добавлена в более ранние версии. __Внимание!!! Работает только с ZenGL!!!__
    - В данной версии GE создано независимое от платформы поле ввода. Должно работать на всех платформах, но на мобильных платформах и MacOS не проверено. Будет проверено и добавлено в исправления.

    - В дальнейшем ожидается доработка библиотеки GE.

- изменены названия малой части процедур/функций, для более визуального восприятия. В частности __utf8_GetID__ заменена на __utf8_toUnicode__ так как она как раз переводит UTF8 в юникод.

- добавлена функция __function Unicode_toUTF8(Symb: LongWord): UTF8String;__ перевода из юникода в UTF8.

- изменена и ускорена работа с текстом.
    - теперь вы не получите ошибку кода, если символа не существует при загруженном шрифте. Все не существующие символы будут отмечены знаком __"?"__.
    - вы сможете писать на любом языке, но, если шрифт для этого не предназначен, все "не печатаемые" (не определённые в шрифте) символы будут так же отмечены знаком __"?"__. При сохранинии такого текста в файл, вероятнее всего он будет выведен правильно.
    - в демонстрационной версии 6, показана работа со шрифтами. Если вам нужен шрифт определённого размера, вы должны с ним работать через __procedure setFontTextScale(Index: LongWord; fnt: Byte);__, она позволит вам более быстро работать с данным шрифтом. Если не постоянно, то смотрите демонстрационную версию.
    - дополнен ряд функций для работы с текстом-шрифтами. Смотрите в файле zgl_text.pas.
    - созданы процедуры для загрузки/сохранения текста __procedure txt_LoadFromFile(const FileName: UTF8String; out Buf: UTF8String);, procedure txt_SaveFromFile(const FileName: UTF8String; const Buf: UTF8String);__.

- были исправлены некоторые ошибки в коде и изменены части работы с клавиатурой. __keysLast (bold)__ - сейчас работает только для печатаемых клавиш.

- введена процедура постотрисовки. Регистрируется с помощью __zgl_Reg__ и флагом __SYS_POSTDRAW__. Срабатываете данная функция только после того как выведется всё в окно. Бывает нужно, когда нужно работать с видеокартой, но не нужно ни чего выводить.

- теперь обработка клавиатуры/мыши/тачпада необходимо производить с помощью регистрируемой процедуры и флагом __SYS_EVENTS__. Производить их "очистку" больше  нет необходимости.
- добавленны комментарии в некоторые модули. Постарался сразу же добавить и на английском языке.

- были исправления в части кода, о которых уже забыл... )))

при нажатии на картинку перейдёте на видео. Где я переделываю 3-ю демо версию. В конце видео показано, что можно делать несколько полей ввода.

[![переделка demo3](https://zengl.org/screens/screen03.jpg)](https://youtu.be/qb8hxilAI_I)

***
Связь: M12Mirrel@yandex.ru
Так же можно связаться со мной на форумах Lazarus или [ZenGL](http://zengl.org/forum/) и высказать пожелания и недоработки.

Поддержать можно через сбер:
2202200951985520
