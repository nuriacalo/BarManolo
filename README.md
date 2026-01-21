# 🍺 Bar Manolo - App de Gestión de Pedidos

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-State%20Management-blueviolet?style=for-the-badge)

<div align="center">
  <img src="/assets/manolo.png" alt="Logo Bar Manolo" width="200"/>
</div>

---

> **"Bar Manolo"** es una aplicación móvil desarrollada en Flutter para la gestión de un bar. Permite a los camareros crear, gestionar y visualizar los pedidos de las mesas de forma rápida y eficiente.

---

## ✨ Características Principales

| Funcionalidad | Descripción |
| :--- | :--- |
| **Creación de Pedidos** | Añade nuevos pedidos especificando el número de mesa. |
| **Gestión de Productos** | Añade múltiples productos a un pedido desde una lista predefinida. |
| **Listado de Pedidos** | Visualiza todos los pedidos activos con resumen de mesa y total. |
| **Detalle del Pedido** | Desglose completo (producto, cantidad, precio, imagen). |
| **Eliminación** | Elimina pedidos deslizando el elemento (Swipe-to-delete). |
| **Cálculo Automático** | El total se actualiza en tiempo real al modificar productos. |
| **Gestión de Estado** | Uso de `provider` para una arquitectura reactiva. |

## 🛠️ Tecnologías Utilizadas

* **[Flutter](https://flutter.dev):** Framework de UI para crear aplicaciones nativas compiladas.
* **[Dart](https://dart.dev):** Lenguaje de programación optimizado para clientes.
* **Provider:** Wrapper de `InheritedWidget` para la gestión de estado eficiente.

## 📱 Vistas de la Aplicación

### 1. Pantalla Principal (`MyHomePage`)
Muestra una lista de todos los pedidos actuales.
* Navegación a crear pedido o ver detalle.
* Eliminación por deslizamiento.

### 2. Creación de Pedidos (`CrearPedidosScreen`)
Formulario para introducir mesa y productos.
* Muestra resumen provisional de coste.

### 3. Pantalla de Detalle (`PedidoDetailScreen`)
Vista detallada con lista de productos y coste final.

