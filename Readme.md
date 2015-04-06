Práctica iOS Fundamentos
===================



**Respuestas**

 1. Métodos similares al método **isKindOfClass**:
	 - *isMemberOfClass*: Este método retorna YES si el *receiver* es una instancia de la clase especificada. La principal diferencia es que **isKindOfClass**  también saber si el *receiver* es una instancia de una clase heredada de la clase especificada.
	 - *respondsToSelector*: Este método permite saber si el  *receiver* entiende el método que se le pasa por parámetro.
	 - *conformsToProtocol*: Este método permite saber si el *receiver* implementa el protocolo que se le pasa por parámetro.
 2. Para implementar la persistencia decidí hacerlo con la clase *NSCoder* la cual me permite serializar el arreglo de libros con todos sus atributos correspondientes, incluyendo si ha sido marcado como favorito o no. Esta decisión la tomé dado que guardando el JSON, me tocaría guardar paralelamente el estado (favorito o no favorito) de cada libro, y me pareció más sencillo guardar un solo elemento (en este caso el arreglo). Sin embargo, es claro que toda esta funcionalidad se puede implementar de manera mucho más sencilla con Core Data y haciendo uso del NSFetchedResultsController.
 3. La forma como implementé el evento de marcar como favorito un libro en la vista de "detalle" fue hacer lo siguiente:
	 - Recibir el evento proveniente del botón de *Favorite*.
	 - Avisar al modelo, que está implementado con un *singleton*, que ha sido modificado.
	 - Una vez hecho el cambio en el modelo, este envía una notificación a todos los interesados (todas las clases que se han suscrito a dichas notificaciones), para informales que ha cambiado.
	 - Existen más maneras de hacer esto. Por ejemplo se podría crear un protocolo que implementara la clase *Master* y que la clase *Detail* disparara una vez ésta supiera que ya se ha hecho el cambio en el modelo. No obstante, esta aproximación tiene la grave falencia de que por cada controlador que esté interesado en saber información sobre el modelo, hay implementar un protocolo. Por esta razón la mejor manera de informar a los controladores cambios en el modelo, es mediante las notificaciones dado que sólo hay que crear una y suscribir a todos los controladores interesados en ellas. Asimismo, es muy importante *darse de baja* en el *dealloc*.
 4. En este caso, dado que los elementos están ordenados por *tags* es supremamente complicado hacer una actualización por medio de los métodos *insertRowsAtIndexPaths* y *deleteRowsAtIndexPaths*. Si la lista  no estuviera ordenada por *tags* o no tuviera secciones me parece que sí sería plausible utilizar estos dos métodos. 
