
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ДК_СогласованнаяСкидкаПриИзменении(Элемент)
	// ++ Купцов Задача ДК_Доработка 13/09/24
	// Добавлена процедура Изменения скидки
	СогласованиеСкидки(Элемент);
	// --
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	// ++ Купцов Задача Доработка 13/09/24
	// Пересчет с сумарной скидкой
	// Исходный код: 
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	// Новый код: 
	ОбщаяСкидка = 1 - (Объект.ДК_СогласованнаяСкидка + ТекущиеДанные.Скидка)/100;
	
	Если ОбщаяСкидка < 0 Тогда
		ОбщаяСкидка = 0;
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Суммарная скидка больше 100% на: " + ТекущиеДанные.Номенклатура;
	
		Сообщение.Сообщить();
		
	КонецЕсли;
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * ОбщаяСкидка;
	
	РассчитатьСуммуДокумента();
	// --
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

&НаКлиенте
Процедура ДК_ПересчитатьТаблицу(Команда)
	// ++ Купцов Задача ДК_Доработка 13/09/24
	// Добавлена команда пересчета таблицы
	
	ДК_ПересчетСтрокТоваровИУслуг();
	
	// --
КонецПроцедуры

&НаКлиенте
Процедура ДК_ПересчетСтрокТоваровИУслуг()
	
	// ++ Купцов Задача ДК_Доработка 13/09/24
	// Добавлена процедура пересчета таблицы
	Для Каждого Строка Из Объект.Товары Цикл
		РассчитатьСуммуСтроки(Строка);
	КонецЦикла;
	
	Для Каждого Строка Из Объект.Услуги Цикл
		РассчитатьСуммуСтроки(Строка);
	КонецЦикла;
	// --
КонецПроцедуры

&НаКлиенте
Асинх Процедура СогласованиеСкидки(Элемент)
	
	// ++ Купцов Задача ДК_Доработка 13/09/24
	// Добавлена процедура Вопроса задания скидки
	Товары = Элементы.Товары.ТекущиеДанные;
	Услуги = Элементы.Услуги.ТекущиеДанные;
	
	Если Товары = Неопределено И Услуги = Неопределено Тогда
		Возврат;
	Иначе
		Ответ = Ждать ВопросАсинх("Изменен процент скидки. Пересчитать таблицу товаров и услуг?",
		РежимДиалогаВопрос.ДаНет,,КодВозвратаДиалога.Да);
		Если Ответ = КодВозвратаДиалога.Нет Тогда
			Возврат;
		Иначе
			ДК_ПересчетСтрокТоваровИУслуг();
		КонецЕсли;
	КонецЕсли;
	// --
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
