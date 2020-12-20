# ZenGL version 3.27 MacOS beta
**ZenGL** - это бибилотека создающая контекст окна для работы с OpenGL на разных платформах.

**Среда разработки**
- Lazarus/FreePascal
- Delphi

**Поддерживаемые платформы для Lazarus/FreePascal:**
- Windows 32/64
- Linux 32/64
- Android
- *MacOS Cocoa* тестовая версия!!!

**Поддерживаемые платформы для Delphi:**
- Windows 32 (вероятно некоторые демо-версии будут работать и с Windows 64, но точно не все)

***
Для MacOS много не доделано, но оснавная часть работает.
3-я демка работает, но нельзя вводить текст (буду решать для всей библиотеки!)
4-я демка - работает не стабильно. Решить для MacOS не знаю как, но основные режимы работают, поэтому используйте через перезагрузку приложения.
12-я демка не работает, так как подобный рендеринг для MacOS Cocoa считается устаревшим.
15-я и дальнейшие демки не работают.
Библиотеки для видео и физики требуют полной переработки, так как в ZenGL были использованы довольно старые библиотеки. Видео возможно запустится, но для этого надо 
скомпилировать файлы в папке "yuv2rgba".

17-я демка на данное время работать не будет, пока не доработаю её основательно для работы с Android.
18-я демка... извиняюсь, но LCL не будет поддерживаться вообще. Если есть желание, можете предложить решение для LCL, и я его использую.

Введена процедура  **procedure gl_SetCoreGL(mode: Byte);**  
**mode** принимает значения CORE_2_1, CORE_3_2,CORE_4_1 - поэтому умельцы, могут включить нужный им OpenGL и работать именно с ним.  
**устанавливать значение надо до создания окна!!!
