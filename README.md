# Bar Manolo - App de Gestión de Pedidos

![Bar Manolo](/assets/manolo.png)

"Bar Manolo" es una aplicación móvil desarrollada en Flutter para la gestión de un bar. Permite a los camareros crear, gestionar y visualizar los pedidos de las mesas de forma rápida y eficiente.

## ✨ Características

*   **Creación de Pedidos**: Añade nuevos pedidos especificando el número de mesa.
*   **Gestión de Productos**: Añade múltiples productos a un pedido desde una lista predefinida.
*   **Listado de Pedidos**: Visualiza todos los pedidos activos en la pantalla principal, mostrando un resumen con el número de mesa, total de productos y precio total.
*   **Detalle del Pedido**: Consulta el desglose completo de un pedido, incluyendo cada producto, su cantidad, precio unitario y una imagen representativa.
*   **Eliminación de Pedidos**: Elimina pedidos deslizando el elemento en la lista principal.
*   **Cálculo Automático**: El total del pedido se calcula automáticamente a medida que se añaden o modifican productos.
*   **Gestión de Estado**: Utiliza el paquete `provider` para una gestión de estado centralizada y reactiva.

## 🛠️ Tecnologías Utilizadas

*   **Flutter**: Framework de UI para crear aplicaciones nativas compiladas para móvil, web y escritorio desde una única base de código.
*   **Dart**: Lenguaje de programación optimizado para clientes para crear aplicaciones rápidas en cualquier plataforma.
*   **Provider**: Un wrapper alrededor de `InheritedWidget` para hacer la gestión de estado más fácil y eficiente.


## 📱 Vistas de la Aplicación

### Pantalla Principal (`MyHomePage`)
Muestra una lista de todos los pedidos actuales. Desde aquí puedes navegar para crear un nuevo pedido o ver el detalle de uno existente. También puedes eliminar un pedido deslizándolo hacia la izquierda.

### Pantalla de Creación de Pedidos (`CrearPedidosScreen`)
Permite introducir un número de mesa y añadir productos. Muestra un resumen provisional del coste total antes de guardar el pedido.

### Pantalla de Detalle (`PedidoDetailScreen`)
Ofrece una vista detallada de un pedido seleccionado, listando todos los productos, sus cantidades y el coste total final.


