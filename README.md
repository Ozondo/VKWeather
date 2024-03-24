# Тестовое задание VK 
# Основной стек 
- UIKit, MVP+Router, CoreData, URLSession, CoreLocation
# Навигация 
При первом входе приложение запрашивает гео данные с вашего устройства, при нажатии на позитивный ответ, подргужаются данные вашего местоположения (Температуры ,города, страны, скорость ветра, дальность видения , влажность , давление воздуха ) и погода на ближайшие 19 часов (API ForeCast for 30 days оказалось платной :( ), представленной в виде UICollectionView . В этот момент идет кеширование данных при помощи CoreData, т.е. при проблемах с интернетом, либо других проблемах данные будут загружены из кеша.  При отказе в предоставлении геолокации, вас перекидывает на страницу поиска города, где нужно ввести название города. Здесь уже кешируется поисковой запрос и при нажатии на город появится погода ( если нет интернета или другие проблемы)

 
