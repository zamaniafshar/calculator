# calculator

Pattern‑Driven Calculator (Flutter/Dart)

This repository showcases a small but robust calculator engine and UI-facing notifier built with a pattern-first mindset. The focus is on clean, extensible design using:

- Strategy: `Operator`, `DyadicOperator`, `FunctionOperator` with concrete strategies in `operators.dart` and `functions.dart`.
- Factory: `ExpressionFactory.create(token)` maps tokens to domain objects.
- Composite: `Expression` tree composed of `NumberExpression`, `DyadicExpression`, `FunctionExpression`.
- Builder‑like composition: tokens are reduced into an expression tree step‑by‑step (tree assembly via operators’ `create`).
- Observer (UI state): `CalculatorNotifier` extends `ValueNotifier<CalculatorNotifierState>` for reactive UI updates.
- Immutable state: `freezed` for a simple, safe state model.

Directory guide

```
lib/
  calculator/
    calculator.dart              # Orchestrates tokenization, building, evaluation
    expression_tokenizer.dart    # Tokenizes expression (numbers/operators/parentheses)
    expression_factory.dart      # Factory for Numbers/Operators
    expressions.dart             # Composite Expression types
    operators.dart               # Concrete Dyadic strategies (+, -, *, /, ^)
    functions.dart               # Function strategies (sin, log, sqrt) – infra ready
    priority_list.dart           # Centralized precedence + associativity helpers
    strategies.dart              # Operator abstractions (Strategy interfaces)
  logic/
    calculator_notifier.dart     # ValueNotifier façade for UI
    calculator_state.dart        # freezed state (immutable)
    expression_validator.dart    # User input validation & sanitization rules
test/
  calculator_notifier_test.dart  # Feature-level tests for user flows
```

Design patterns in this codebase

1) Strategy (behaviors as pluggable objects)
- `DyadicOperator` and `FunctionOperator` define the behavior contract.
- Concrete strategies implement `apply` and supply `priority` and associativity:
  - `Add`, `Subtract`, `Multiply`, `Divide`, `Power` in `operators.dart`.
  - `SinFn`, `LogFn`, `SqrtFn` in `functions.dart` (infrastructure present; see notes below).

2) Factory (creation logic centralized)
- `ExpressionFactory.create(token)` returns either a `NumberExpression` or a concrete operator strategy based on the token.
- Adding a new operator is a local change: define the strategy, register it in the factory, and (optionally) adjust `PriorityList`.

3) Composite (uniform tree of expressions)
- `Expression` is the component interface, with leaf `NumberExpression` and composite nodes `DyadicExpression` and `FunctionExpression`.
- Evaluation is a simple `evaluate()` call on the root, delegating recursively.

4) Builder‑like composition (progressive assembly)
- `Calculator.calculate()` tokenizes the input and maps tokens via the factory to a mixed list of numbers and operators.
- `_calculate()` repeatedly finds the highest‑priority operator, replaces its neighborhood with a newly created composite expression node, and continues until a single `Expression` remains.
- This reduction behaves like a lightweight builder for the expression tree (not the GoF Builder pattern per se, but a structured assembly pipeline).

5) Observer + immutable state (UI friendly)
- `CalculatorNotifier` wraps the domain with `ValueNotifier<CalculatorNotifierState>` to decouple UI and logic.
- `freezed` ensures value‑equality and ergonomic copy‑with semantics for state transitions.

How calculation works

1) Tokenization: `ExpressionTokenizer.tokenize()`
- Extracts numbers (including decimals) and operators `+ - * / ^ % ( )` while stripping whitespace.
- Current validator and factory primarily support numbers and dyadic operators; parentheses and functions are reserved for future extension.

2) Building & reducing
- Tokens → `ExpressionFactory` → list of `NumberExpression | Operator`.
- While more than one element exists:
  - `_findHighestPriority()` selects the next operator to reduce.
  - For `DyadicOperator`, pick left/right neighbors and call `create(left, right)` → `DyadicExpression`.
  - For `FunctionOperator`, pick the argument neighbor and call `create(arg)` → `FunctionExpression`.
  - Replace the slice with the new node and continue.

3) Precedence and associativity
- `PriorityList` centralizes precedence: `^` and functions have higher precedence than `*`/`/`, which is higher than `+`/`-`.
- Associativity is encoded on each operator. For example, `Power` overrides `isLeftAssociative` to be right‑associative, yielding the expected `2^3^2 = 2^(3^2) = 512`.

Input validation rules (UX)

`ExpressionValidator` enforces simple, predictable input:
- Allows digits and a single dot per number; `.` after an operator is treated as `0.`.
- Disallows unknown symbols; prevents starting with `+`, `*`, `/`.
- Replaces consecutive operators (typing `1+-` yields `1-`).
- Keeps expressions calculable as you type; invalid intermediate states surface `error: "Invalid expression"` until they become valid again.

Testing

Feature tests in `test/calculator_notifier_test.dart` cover:
- Initial state and incremental input (char‑by‑char) with live calculation.
- `getResult()` behavior (replaces expression with final value, clears result).
- `clear()` and `deleteLast()` semantics.
- Operator replacement and decimal rules.
- Operator precedence and power right‑associativity.
- Division by zero behavior (`Divide.apply` returns `0` by design here).
- Error surfacing and clearing.

Run tests:

```
flutter test
```

SOLID‑friendly design

- Single Responsibility: tokenization, validation, operators, expressions, calculator orchestration, and UI state are separated.
- Open/Closed: add operators/functions without modifying existing evaluation logic; mostly register in the factory and (if needed) update `PriorityList`.
- Liskov Substitution: all operators honor the `Operator` contract; substitutable at call sites.
- Interface Segregation: slim, focused interfaces (`DyadicOperator`, `FunctionOperator`).
- Dependency Inversion (pragmatic): UI depends on the abstract notifier interface (`ValueListenable` semantics). For greater testability, inject `Calculator`/`ExpressionValidator` into `CalculatorNotifier`.

Extending the engine

Add a new dyadic operator (e.g., modulo `%`):
1) Implement in `operators.dart` (give it a `priority` and `apply`).
2) Register symbol in `ExpressionFactory._createOperator`.
3) If needed, add precedence to `PriorityList`.
4) Add tests (precedence, associativity, edge cases like zero/negative inputs).

Add a new function (e.g., `tan`):
1) Implement in `functions.dart` (`apply`, `priority`, `create`).
2) Update `ExpressionFactory` to map the `tan` token to the new function.
3) Extend `ExpressionTokenizer` and `ExpressionValidator` to accept letter tokens (e.g., `tan(` … `)`).
4) Add tests.

Parentheses support (roadmap idea)

Currently, parentheses are tokenized but not yet interpreted by the reducer. Options to add support:
- Implement a shunting‑yard algorithm to convert to RPN, then build a tree.
- Or perform recursive descent parsing where parentheses spawn sub‑reductions.

Behavioral notes and trade‑offs

- Division by zero currently returns `0` (see `Divide.apply`); you may change this to throw or return `double.infinity` based on product requirements.
- Negative numbers: the `ExpressionValidator` allows leading `-`, but unary minus isn’t modeled as a distinct operator yet. Consider adding a unary operator or parser support if you need robust negatives.
- Functions infrastructure exists but isn’t wired through the validator/factory by default. See “Extending the engine”.

Local development

```
flutter run
flutter test
```

License

MIT 
