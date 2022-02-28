# ZenGL version 3.29 + MacOS Cocoa - beta version + Green Engine v1.0

[Eng](#English)  
[Rus](#Russian)

<a name="English"></a>Eng:
-------------

[zengl](https://zengl.org) - the original site of the library's creator.

[google arhive](https://code.google.com/archive/p/zengl/)

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

See the changes in the __Update_ZenGL.txt__ file.  Sorry, the information is only in Russian. :(

Important update: This version has updated OpeGL to the latest version as per end of 2021. All extensions have also been updated. Files: __zgl_pasOpenGL.pas__, __zgl_GLU.pas__, __zgl_GLX_WGL.pas__, __zgl_gltypeconst.pas__, __GLdefine.cfg__.

Ways to work with 3D were not implemented. You will need to do this manually or set __oglMode__ to 3. I haven't tested it! You can rewrite the procedure __Set3DMode(FOVY: Single = 45);__ and set all the parameters yourself.

Clicking on the image will take you to the video. Where I redo the 3rd demo. At the end of the video, it shows that you can make multiple input fields.

[![demo3 remake](https://zengl.org/screens/screen03.jpg)](https://youtu.be/qb8hxilAI_I)

***
Communication: M12Mirrel@yandex.ru
You can also contact me on the Lazarus forums or [ZenGL](http://zengl.org/forum/) and express your wishes and shortcomings.

You can support through Sberbank:
2202200951985520

The original source code is at [GutHub](https://github.com/Seenkao/New-ZenGL) other sites may have a back branch.

Please write about the errors found in the process of working with ZenGL. )))

****

<a name="Russian"></a>Rus:
-------------

[zengl](https://zengl.org) - изначальный сайт создателя библиотеки.

[архив гугла](https://code.google.com/archive/p/zengl/)

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
Изменения смотрите в файле __Update_ZenGL.txt__.

Важное обновление: в данной версии обновлён OpeGL до последней версии согласно конца 2021 года. Так же обновлены все расширения. Файлы: __zgl_pasOpenGL.pas__, __zgl_GLU.pas__, __zgl_GLX_WGL.pas__, __zgl_gltypeconst.pas__, __GLdefine.cfg__.

Способов работы с 3D не реализовывалось. Вам надо будет делать это вручную или __oglMode__ приравнять 3. Я не проверял работоспособность! Вы можете переписать процедуру __Set3DMode(FOVY: Single = 45);__ и задайть все параметры самим.

при нажатии на картинку перейдёте на видео. Где я переделываю 3-ю демо версию. В конце видео показано, что можно делать несколько полей ввода.

[![переделка demo3](https://zengl.org/screens/screen03.jpg)](https://youtu.be/qb8hxilAI_I)

***
Связь: M12Mirrel@yandex.ru
Так же можно связаться со мной на форумах Lazarus или [ZenGL](http://zengl.org/forum/) и высказать пожелания и недоработки.

Поддержать можно через сбер:
2202200951985520

Оригинальный исходный код находится на [GutHub](https://github.com/Seenkao/New-ZenGL) на других сайтах может отстающая ветка.

Просьба писать об ошибках выявленных в процессе работы с ZenGL. )))
