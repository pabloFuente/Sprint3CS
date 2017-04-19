Feature:

Probar youtube

Como
	Usuario No registrado
    
Quiero
	Poder hacer pruebas sobre los demás usuarios
     

Scenario: Si buscamos el nombre de un usuario famoso, el primer video tiene que ser suyo.
	Given El usuario "AuronPlay"
    When Voy a Youtube
    And Hago la búsqueda
	Then El primer video tiene como autor el usuario dado
    
Scenario: Si buscamos el nombre de un usuario (no famoso), el primer no tiene que ser suyo.
	Given El usuario "PedroJ"
    When Voy a Youtube
    And Hago la búsqueda
    Then El primer video no tiene como autor el usuario dado

Scenario: Si buscamos un video, tiene que tener una duración dada.
	Given Url de un video "https://www.youtube.com/watch?v=JGwWNGJdvx8"
    When Voy a video dado
    Then Tiene que durar "4:23"

Scenario: Si buscamos un video cualquiera, si sus comentarios están ordenados de mejor a peor, el primero debe tener más likes que el segundo
    Given Url de un video "https://www.youtube.com/watch?v=SC4xMk98Pdc"
    When Voy a video dado
    Then El primer comentario debe tener más likes que el segundo

Scenario Outline: Si vamos a un canal y pinchamos cualquiera de sus videos, su categoria debe ser la del canal
    Given El canal <canal>
    When Voy a Youtube
    And Pincho el canal en el menu
    And Pincho cualquier video
    Then Debe contener el canal como categoría
   
    Examples: 

    | canal        |
    | Música       |
    | Deportes     |
    | Noticias     |
