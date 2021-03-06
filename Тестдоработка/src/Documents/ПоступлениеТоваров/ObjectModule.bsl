
#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, Режим)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПоступлениеТоваровТовары.Номенклатура КАК Номенклатура,
	|	ПоступлениеТоваровТовары.Количество КАК Количество,
	|	ПоступлениеТоваровТовары.НомерСтроки КАК НомерСтроки
	|ИЗ
	|	Документ.ПоступлениеТоваров.Товары КАК ПоступлениеТоваровТовары
	|ГДЕ
	|	ПоступлениеТоваровТовары.Ссылка = &Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Движение = Движения.ТоварыНаСкладах.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Склад = Склад;
		Движение.Номенклатура = Выборка.Номенклатура;
		Движение.СвободныйОстаток = Выборка.Количество;
	КонецЦикла;
	
	Движения.ТоварыНаСкладах.Записывать = Истина;
	Движения.Записать();
	
КонецПроцедуры

#КонецОбласти

