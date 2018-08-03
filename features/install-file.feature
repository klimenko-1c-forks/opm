# language: ru

Функциональность: Настройки продукта

Как разработчик
    Я хочу иметь устанавливать пакет из файла
    Чтобы иметь возможность проверять локальные версии пакетов


Контекст: Тестовый контекст
    Допустим Я очищаю параметры команды "opm" в контексте
    И Я устанавливаю путь выполнения команды "opm" к текущей библиотеке
    И Я создаю временный каталог и сохраняю его в переменной "КаталогСборкиПакета"
    И Я создаю временный каталог и сохраняю его в переменной "РабочийКаталог"
    И Я выполняю сборку пакета "fixtures/testpackage"  в каталог из переменной "КаталогСборкиПакета"
    И Я сохраняю файл пакета из каталога "КаталогСборкиПакета" в переменную "ИмяФайлаПакета"

Сценарий: Установка пакета из файла в локальный каталог
    Допустим Я установил рабочий каталог из переменной "РабочийКаталог"
    И Я добавляю параметр "install" для команды "opm"
    И Я добавляю параметр "--local" для команды "opm"
    И Я добавляю опцию "-f" для команды "opm" из переменной "ИмяФайлаПакета"
    Когда Я выполняю команду "opm"
    Тогда Вывод команды "opm" содержит "ИНФОРМАЦИЯ - Установка завершена"
    И Вывод команды "opm" не содержит "Внешнее исключение"
    И Код возврата команды "opm" равен 0
    И В каталоге из переменной "РабочийКаталог" создается файл или каталог "oscript_modules"