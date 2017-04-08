# VIP architecture example

This project is a simple example of VIP architecture and network foundation on iOS using:
- RxSwift for asynchronous tasks and communication between the different components
- Swinject for dependency injection
- SnapKit for UI constraint management

There are some differences to the original VIP (real abstraction of the different components, communication with Rx)

# Specificities

- The different components (View, Interactor and Presenter) are abstracted by the protocol `ViewType`, `Interactor` and `Presenter`.
- The ViewController acts like a bridge between View, Interactor and Presenter. It holds these instances.
- View contains UI elements and exposed an update method with a `Driver` of `ViewState`, through the protocol `ViewType`.
- Interactor handles business logic and holds Model instances. It takes in input an `EventRequest`, representation of a request from the View.
- Presenter handles transformation of data to ViewModel. It takes in input an `EventResponse`, representation of a response from the Interactor.
- Model are abstracted with protocol and always injected in Interactor.
- Data layer follows the Repository pattern abstracted by the protocol `Repository`.
- About folder hierarchy:
	- Foundation contains all transversed extensions/dependencies. Also, there is all the abstraction of VIP components.
	- Scene contains ViewController/Presenter/Interactor/View/ViewModel for each feature of the app.
