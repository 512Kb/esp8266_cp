# Температурный контроллер.

###### Устройство представляет собой контроллер температурных зон помещений и может быть использован как модуль для умного дома. 

Сердцем устройства является сборка esp 12f, посаженная на плату Wemos d1 mini.

Управляет устройство 4-х канальной группой реле. 
За неимением достаточного количества портов в/в был использован чип i2c-расширителя PCF8574T.
В качестве температурных сенсоров взяты датчики ds18b20, под которые предусмотренно 5 клемных колодок и термопара K-типа с контроллером на чипе max6675 для регистрации высоких температур.

Девайс способен управлять блоком реле посредством контроля заданного температурного диаппазона от датчиков или задания времени срабатывания(чип RTC ds3231)

Файл печатной платы [pcb.dip](https://github.com/512Kb/esp8266_tcp/blob/master/Schematic/pcb.dip) выполнен в формате DipTrace PCB layout. Схему устройства приводить не стал ввиду её исключителной простоты. Впрочем, схему вы можете получить путем несложного
реверса печатной платы. 

На плате дополнительно имеется пъезокерамический звукоизлучатель и отдельно кнопка сброса wi-fi к дефолтным установкам, а так же кнопка, позволяющая выполнить перепрошивку esp8266 непосредственно без съема блока wemos.

Саму плату esp12-f необходимо прошить заранее заготовленным прошивочным образом (можно использовать [nodemcu.bin](https://github.com/512Kb/esp8266_tcp/blob/master/Bin/nodemcu.bin) из дистрибутива). Собственно, образ прошивки NodeMCU можно скомпиллировать здесь: https://nodemcu-build.com/ 
В опциях web-интерфейса компиллятора дополнительно выбрать библиотеки: bit, CJSON, I2C, 1-ware, PWM. 
После компилляции будет выдано 2 образа: integer и float. Брать нужно второй, поскольку
в скриптах есть расчет чисел с плавающей запятой. 

Так как в качестве платформы была использована NonOs NodeMCU, прошивка написана в
скриптах Lua. Из-за сложного алгоритма управления, повлекшего за собой написание
большого объема кода, который сам по себе требует достаточно приличного объема оперативной памяти(которой, естественно, NodeMCU выделяет не много под размещение скриптов и переменные), основные файлы пришлось порезать практически на отдельные функций и выполнять их с последующей выгрузкой из памяти. 
##### Сборка скриптов, настройка:
* После прошивки образа NodeMCU (файл [nodemcu.bin](https://github.com/512Kb/esp8266_tcp/blob/master/Bin/nodemcu.bin)), отправляем на устройство все файлы [*.lua](https://github.com/512Kb/esp8266_tcp), идущие в дистрибутиве. Компиллируем их в байт-код [*.lc]
*  Туда же отправляем все файлы [cfg_*](https://github.com/512Kb/esp8266_tcp/tree/master/Configs). Файл cfg_wifi советую предварительно отредактировать в соответствие с настройками вашей wi-fi сети. 
* Файл [cfg_passw](https://github.com/512Kb/esp8266_tcp/blob/master/Configs/cfg_passw) задает пароль доступа к настройкам устройства через веб-интерфейс. Можно предварительно отредактировать.
* Обязательно отправить на флеш устройства файл [Index.html](https://github.com/512Kb/esp8266_tcp/blob/master/FrontEnd/Index.html) - это консоль управления, которая отобразится браузером при наборе сетевого адреса устройства.

Все настройки веб-интерфейса достаточно просты и интуитивно понятны.

* ##### Оборудование, использованное при постройке устройства:

* ######  [Блок реле 4х-канальный](https://www.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=AS_20170123032502&SearchText=4+channel+relay+module&blanktest=0&tc=af)
* ###### [Модуль Wemos d1 mini](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213030526&SearchText=wemos+d1+mini&blanktest=0&tc=af)

* ######  [Блок питания](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213030918&SearchText=tsp-05&blanktest=0&tc=af)

* ######  [Термопара](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213031103&SearchText=k-type+max6675&blanktest=0&tc=af)

* ######  [Термодатчик ds18b20](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=AS_20170213031136&SearchText=ds18b20&blanktest=0&tc=af)

* ######  [Кнопка тактовая](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213032846&SearchText=G66+button&blanktest=0&tc=af)

* ######  [Клемная колодка высоковольтная 2-pin](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213033120&SearchText=2+Pin+5.08+%D0%BC%D0%BC&blanktest=0&tc=af)

* ######  [Клемная колодка 2-pin](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213033806&SearchText=2+Pin+2.54+%D0%BC%D0%BC+0.1&blanktest=0&tc=af)

* ######  [Клемная колодка 3-pin](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213033855&SearchText=3+Pin+2.54+%D0%BC%D0%BC+0.1&blanktest=0&tc=af)

* ######  [Латунная стойка M3 10 мм](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213033515&SearchText=copper+pillars+M3+10+%D0%9C%D0%9C&blanktest=0&tc=af)

* ######  [Держатель батареи CR2032](https://ru.aliexpress.com/wholesale?ltype=wholesale&d=y&origin=y&isViewCP=y&catId=0&initiative_id=SB_20170213061226&SearchText=2032+holder&blanktest=0&tc=af)


Типоразмеры и номиналы остальных элементов обозначены на плате.
