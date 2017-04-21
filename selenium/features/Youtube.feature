Feature:

Comprobar la búsqueda por filtros

Como
	Usuario No registrado

Quiero
	Poder realizar búsquedas por filtros

Background:
    Given El usuario "AuronPlay"
    And Voy a Youtube
    And Hago la búsqueda

Scenario: Si buscamos el nombre de un usuario y filtramos por canal, todos los elementos deben ser canales
    When Selecciono el filtro "Canal"
	Then Todos los resultados deben ser canales

Scenario: Si buscamos el nombre de un usuario y filtramos por video, todos los elementos deben ser videos
    When Selecciono el filtro "Vídeo"
	Then Todos los resultados deben ser videos

Scenario: Si buscamos el nombre de un usuario y filtramos por lista de reproducción, todos los elementos deben ser listas de reproducción
    When Selecciono el filtro "Lista de reproducción"
	Then Todos los resultados deben ser listas de reproduccion

Scenario: Si buscamos el nombre de un usuario y filtramos por duración mayor de 20 min, todos los elementos deben tener almenos esa duración
    When Selecciono el filtro "Larga (más de 20 minutos)"
	Then Todos los resultados deben tener una duración mínima de 20 minutos

Scenario: Si buscamos el nombre de un usuario y filtramos por duración menor de 4 min, todos los elementos deben tener como máximo esa duración
    When Selecciono el filtro "Corta (menos de 4 minutos)"
	Then Todos los resultados deben tener una duración máxima de 4 min
