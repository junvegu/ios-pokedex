# Pokedex

Pokedex es una aplicación móvil diseñada para proporcionar información detallada sobre los 151 Pokémon de la **primera generación**. La aplicación está construida siguiendo los principios de **Arquitectura Limpia (Clean Architecture)** y el patrón de diseño **MVVM (Model-View-ViewModel)**, asegurando un código modular, mantenible y escalable. La interfaz de usuario está desarrollada con **UIKit**, y los **ViewModels** implementan **data bindings** utilizando **Combine**. Además, se emplea el **patrón de Coordinador** para gestionar la navegación y se incorporan **pruebas de instantáneas (Snapshot Tests)** junto con **pruebas de interfaz de usuario (UITests)** para garantizar la calidad y consistencia de la aplicación.


https://github.com/user-attachments/assets/899ecf43-55ee-4b55-812a-6211eb925577



https://github.com/user-attachments/assets/2f0f08f8-8b8e-4cd1-8b4f-8eac9b294402


## Características

- **Exploración de Pokémon**: Navega y descubre información detallada sobre cada uno de los 151 Pokémon de la primera generación, incluyendo estadísticas, habilidades y evoluciones.
- **Búsqueda por Nombre**: Filtra Pokémon rápidamente ingresando su nombre en la barra de búsqueda.

## Arquitectura

La aplicación sigue una **Arquitectura Limpia** dividida en varias capas, cada una con responsabilidades bien definidas:

- **Presentación (Presentation)**: Contiene las vistas y los ViewModels, gestionando la interfaz de usuario y la lógica de presentación.
- **Dominio (Domain)**: Incluye las entidades y casos de uso, representando la lógica de negocio pura.
- **Infraestructura (Infrastructure)**: Maneja la obtención de datos desde fuentes remotas o locales, implementando los repositorios definidos en la capa de dominio.

Esta estructura promueve la separación de responsabilidades, facilitando el mantenimiento y la escalabilidad de la aplicación.

## Patrón MVVM con UIKit y Combine

El patrón **Model-View-ViewModel (MVVM)** se implementa de la siguiente manera:

- **Model**: Representa las estructuras de datos y entidades del dominio.
- **View**: Comprende las vistas que interactúan con el usuario, construidas utilizando **UIKit** para una interfaz robusta y personalizable.
- **ViewModel**: Actúa como intermediario entre la Vista y el Modelo, gestionando la lógica de presentación y proporcionando datos listos para mostrar en la interfaz. Los **ViewModels** utilizan **Combine** para implementar data bindings reactivos, permitiendo que las vistas se actualicen automáticamente en respuesta a cambios en los datos.

Este enfoque permite una clara separación entre la lógica de negocio y la interfaz de usuario, facilitando las pruebas y el mantenimiento.

## Patrón de Coordinador

Para manejar la navegación de manera eficiente, la aplicación implementa el **patrón de Coordinador**. Este patrón delega la responsabilidad de la navegación a objetos coordinadores, desacoplando las vistas de los detalles de navegación y promoviendo una mayor cohesión y reutilización de componentes.

## Pruebas

La calidad y estabilidad de la aplicación se aseguran mediante diferentes tipos de pruebas:

- **Pruebas Unitarias**: Verifican la lógica de negocio en las capas de Dominio e Infraestructura.
- **Pruebas de Instantáneas (Snapshot Tests)**: Garantizan que la interfaz de usuario se renderice correctamente y detectan cambios visuales inesperados.
- **Pruebas de Interfaz de Usuario (UITests)**: Evalúan la interacción del usuario con la aplicación, asegurando que los flujos de navegación y las funcionalidades clave operen como se espera.

## Requisitos del Sistema

- **iOS 15.0** o superior
- **Xcode 13.0** o superior

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
