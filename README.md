# TranslateGuessr
Ignacio Espinoso Ribeiro

### Overview
This is a simple project developed in around 8 hours. It uses a VIP architecture to further adhere to the Single Responsability Principle, splitting business logic from display.

Due to this choice, going to the second milestone of implementing a timeout timer and end scenario was fairly simple, as each class responsability is quite clear.

#### View
The is a simple `UIView` based on the UI reference, with labels informing each string and count, besides the two evaluation buttons. Touching each button triggers the interactor to evaluate the response

#### Interactor
The interactor is responsible for the main game mechanics. It generates the input for the View, as well as assesses user responses. It is also responsible for evaluating if any end scenario is met.

#### Presenter
The Presenter is a simple interface that, with the View Controller, interacts with the View displayed content.

--------
### Time Management
The first half of the project was dedicated to creating the foundation of the architecture: the main view, presenter and interactor, as well as primary model classes and structs.

On the second half of the project, I worked on: 
1. The view and its constraints, as well as its behavior when triggering the Interactor
2. Implement end scenario / timeout
3. Implement Unit tests

### Trade-offs

#### Restrictions
Due to time restriction, I chose to simplify a set of behaviors that, if working on the app in the future, should be revisited:
1. Turn the `Service` module more generic, as in the future this could well be an external API call;
2. Further componentize the `EvaluatorView` elements, as they could be reused in potential new game scenarios;
3. Increase test coverage;
4. Improve UX and UI, initially with label and button elements, and then with an end scenario animation.


#### Short-term priority
From these potential improvements, the first priority would be the test coverage increase, to avoid any bugs before moving on to new features.