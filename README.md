# Pomodoro Timer Application

## 1. Introduction

This README describes the design, implementation, and evaluation of a Pomodoro Timer application developed using the Swift programming language and Apple platform technologies. The application is intended to support time management based on the Pomodoro technique by organizing work and rest intervals and providing structured user feedback.

The purpose of this work is to design and implement a functional application that meets the technical and functional requirements of the assignment, demonstrates correct architectural decisions, and complies with quality criteria related to usability, performance, and testability.

## 2. Problem Statement

The task was to develop a timer-based application that alternates between work sessions and break sessions. The application must:

* Support configurable durations for work and break sessions
* Track completed work sessions
* Display a feedback prompt after every second completed work session
* Require explicit user interaction to start break sessions
* Maintain predictable and testable application logic

The application must be implemented in Swift using a modern architectural approach and include automated tests.

## 3. Functional Requirements

The following functional requirements were identified and implemented:

1. The application provides two operating modes: work mode and break mode.
2. A work session is started manually by the user.
3. After a work session finishes, the application increments the number of completed Pomodoro sessions.
4. A break session does not start automatically and must be started manually by the user.
5. A feedback prompt is displayed only after every second completed work session.
6. The user can start, pause, and reset the timer at any time.
7. The current timer state is reflected in the user interface.

## 4. Non-Functional Requirements

The application satisfies the following non-functional requirements:

* **Usability**: Clear separation of actions for starting work and break sessions. No implicit background state changes.
* **Reliability**: Deterministic state transitions and protection against invalid states.
* **Performance**: Low CPU usage during timer execution and UI rendering.
* **Maintainability**: Modular structure and separation of concerns.
* **Testability**: Business logic isolated from UI and system timers.

## 5. Architecture and Design

The application follows the Model–View–ViewModel (MVVM) architectural pattern. 
<img width="503" height="400" alt="pomodoro" src="https://github.com/user-attachments/assets/f60856f2-54f0-4190-b536-164759fa1afd" />


### 5.1 Model

The model layer includes the `PomodoroSession` structure, which stores:

* Work duration
* Break duration
* Number of completed Pomodoro sessions

This structure is independent of UI and platform-specific logic.

### 5.2 ViewModel

The `PomodoroViewModel` class encapsulates all business logic and state transitions. It is annotated with `@MainActor` to ensure thread safety when interacting with the user interface.

The ViewModel is responsible for:

* Managing the current mode (work or break)
* Starting and stopping the timer
* Incrementing completed Pomodoro counters
* Determining when the feedback prompt should be displayed

All state changes are explicit and observable.

### 5.3 View

The view layer observes the ViewModel and renders the current state. It contains no business logic and does not directly manage timers or counters.

## 6. Timer Management

Timer functionality is implemented using an abstracted `TimerService`. This approach allows:

* Replacement of the real timer with a mock timer in tests
* Deterministic testing of time-dependent logic
* Reduced coupling between system APIs and business logic

The timer runs only during an active session and is stopped during pauses or resets.

## 7. User Interaction Logic

After the completion of a work session:

* The completed Pomodoro counter is incremented
* The application switches to break mode
* The break timer does not start automatically

The feedback prompt is shown only if the number of completed Pomodoro sessions is divisible by two. This rule is implemented directly in the ViewModel.

## 8. Testing

Automated tests are implemented using the XCTest framework.

### 8.1 Unit Tests

Unit tests validate:

* Correct state transitions between work and break modes
* Manual start behavior for break sessions
* Correct logic for displaying the feedback prompt
* Timer start, pause, and reset behavior

Mock implementations of the timer service are used to isolate the ViewModel logic.

### 8.2 Test Execution

All tests are executed using Xcode’s Test Navigator or the `Cmd + U` shortcut. Successful execution confirms correctness of the application logic.

## 9. Performance Evaluation

Performance analysis was conducted using Xcode Instruments.

The results show that:

* Application launch time is dominated by system framework initialization
* Timer tick processing does not introduce measurable CPU overhead
* UI rendering costs are within acceptable limits

No performance bottlenecks related to custom application logic were identified.

## 10. Error Handling and Stability

The application prevents invalid state transitions by centralizing logic in the ViewModel. Public APIs expose only valid actions, reducing the risk of runtime errors.

Concurrency issues are avoided by restricting state mutations to the main actor.

## 11. Security and Privacy

The application does not collect, store, or transmit personal data. No network connections or external services are used. All data exists only in memory during application runtime.

## 12. Conclusion

The developed Pomodoro Timer application meets all stated functional and non-functional requirements. The use of MVVM architecture, explicit state management, and automated testing ensures correctness, maintainability, and reliability. The project demonstrates proper application of Swift language features and Apple platform development practices.

## App Screens

| Setting Timer | Start Screen | Work Session | Complete Session | Sending Feedback | Completed Sessions Counter|  
|---------------|-------------|--------------|-------------------|------------------|------------------|
| <img width="185" height="400" alt="Simulator Screenshot - iPhone 12 - 2025-12-16 at 21 55 37" src="https://github.com/user-attachments/assets/b7d24aca-d86e-4409-b294-6698a9be817a" /> | <img width="185" height="400" alt="Simulator Screenshot - iPhone 12 - 2025-12-16 at 21 55 44" src="https://github.com/user-attachments/assets/753fe8f0-a23d-456d-8089-35f0f2d67edc" /> | <img width="185" height="400" alt="Simulator Screenshot - iPhone 12 - 2025-12-16 at 21 55 49" src="https://github.com/user-attachments/assets/1745ee13-ef7c-475e-b5cc-72f35abd58eb" /> | <img width="185" height="400" alt="Simulator Screenshot - iPhone 12 - 2025-12-16 at 21 56 59" src="https://github.com/user-attachments/assets/1680e057-c072-461d-b90a-406907c51ead" /> | <img width="185" height="400" alt="Simulator Screenshot - iPhone 12 - 2025-12-16 at 21 58 08" src="https://github.com/user-attachments/assets/0a746e58-d0c9-4c81-a9b4-d6420f1c0576" /> |<img width="185" height="400" alt="Simulator Screenshot - iPhone 12 - 2025-12-16 at 22 36 01" src="https://github.com/user-attachments/assets/ab88cf32-8984-4a77-9f25-dbd6f1ed6d6e" /> |
  
