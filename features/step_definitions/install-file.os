﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯВыполняюСборкуПакетаВКаталогИзПеременной");
	ВсеШаги.Добавить("ЯСохраняюФайлПакетаИзКаталогаВПеременную");
	ВсеШаги.Добавить("ЯУстановилРабочийКаталогИзПеременной");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	
КонецПроцедуры


//Я выполняю сборку пакета "fixture/testpackage"  в каталог из переменной "КаталогСборкиПакета"
Процедура ЯВыполняюСборкуПакетаВКаталогИзПеременной(Знач ПутьКаталогуПакета, Знач ИмяПеременнойКаталогаСборки) Экспорт
	
    ПутьККаталогуПакета = ОбъединитьПути(ТекущийСценарий().Каталог, ПутьКаталогуПакета);

	КаталогСборкиПакета = БДД.ПолучитьИзКонтекста(ИмяПеременнойКаталогаСборки);

	СтрокаЗапуска = СтрШаблон("oscript ""%1"" build --out %2 %3", ПутьКИсполняемомуФайлу(),  КаталогСборкиПакета, ПутьККаталогуПакета );
	КодВозврата = ВыполнитьКоманду(СтрокаЗапуска);
	
	Ожидаем.Что(КодВозврата, 
		"Ожидали, что сборка пакета (opm build) завершится с кодом возврата 0, а получили другое значение").
		Равно(0);

КонецПроцедуры


//Я установил рабочий каталог из переменной "РабочийКаталог"
Процедура ЯУстановилРабочийКаталогИзПеременной(Знач ИмяКаталога) Экспорт
   	РабочийКаталог = БДД.ПолучитьИзКонтекста(ИмяКаталога);

	УстановитьТекущийКаталог(РабочийКаталог);

КонецПроцедуры

//Я сохраняю файл пакета из каталога "КаталогСборкиПакета" в переменную "ИмяФайлаПакета"
Процедура ЯСохраняюФайлПакетаИзКаталогаВПеременную(Знач ИмяПеременнойКаталога, Знач ИмяПеременнойФайла) Экспорт
	ПутьВременногоКаталога = БДД.ПолучитьИзКонтекста(ИмяПеременнойКаталога);
	МассивФайлов = НайтиФайлы(ПутьВременногоКаталога, "*.ospx", Ложь);
	Ожидаем.Что(МассивФайлов.Количество(), "Должны были найти только 1 собранный пакет, а не несколько").Равно(1);
	ФайлПакета = МассивФайлов[0];
	БДД.СохранитьВКонтекст(ИмяПеременнойФайла, ФайлПакета.ПолноеИмя);

КонецПроцедуры

Функция ВыполнитьКоманду(Знач СтрокаКоманды, ТекстВывода = "")
	Команда = Новый Команда;
	Команда.ПоказыватьВыводНемедленно(Истина);
	
	Команда.УстановитьСтрокуЗапуска(СтрокаКоманды);

	КодВозврата = Команда.Исполнить();
	ТекстВывода = Команда.ПолучитьВывод();

	Если КодВозврата <> 0 Тогда
		// Лог.Информация(ТекстВывода);
		Сообщить(ТекстВывода);
	КонецЕсли;
	Возврат КодВозврата;
КонецФункции

Функция ПутьКИсполняемомуФайлу()

	Возврат ОбъединитьПути(КаталогБиблиотеки(), "src", "cmd", "opm.os");

КонецФункции

Функция КаталогFixtures()
	Возврат ОбъединитьПути(КаталогБиблиотеки(), "tests", "fixtures");
КонецФункции

Функция КаталогБиблиотеки()
	Возврат ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..");
КонецФункции
