# calculator

![Calculator Screenshot](https://github.com/zamaniafshar/calculator/blob/87f8575baed9e23fe287371c36bebc871e7ee593/resources/Screenshot%202025-08-26%20at%2017.10.01.png)



This repository showcases a small but robust calculator core and UI-facing notifier built with a pattern-first mindset. The focus is on clean, extensible design using:

- Strategy: `Operator`, `DyadicOperator`, `FunctionOperator` with concrete strategies in `operators.dart` and `functions.dart`.
- Factory: `TokenFactory.create(token)` maps tokens to domain objects.
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
    token_factory.dart           # Factory for Numbers/Operators
    expressions.dart             # Composite Expression types
    operators.dart               # Concrete Dyadic strategies (+, -, *, /, ^)
    functions.dart               # Function strategies (sin, log, sqrt) – infra ready
    priority_list.dart           # Centralized precedence + associativity helpers
    strategies.dart              # Operator abstractions (Strategy interfaces)
  bloc/
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
- `TokenFactory.create(token)` returns either a `NumberExpression` or a concrete operator strategy based on the token.
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
- Tokens → `TokenFactory` (in token_factory.dart) → list of `NumberExpression | Operator`.
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

Testing and Quality Assurance

The project includes comprehensive test coverage to ensure reliability and correctness:

### Unit Tests
Located in `test/calculator_test.dart`:
- Core calculation logic
- Operator precedence and associativity
- Edge cases and error handling

### Integration Tests
Located in `test/calculator_notifier_test.dart`:
```dart
// Example test structure
void main() {
  group('CalculatorNotifier', () {
    test('basic operations', () {
      // Tests for +, -, *, /, ^
    });
    test('decimal handling', () {
      // Tests for proper decimal point behavior
    });
    // ... more test groups
  });
}
```

### Running Tests
1. Ensure you have Flutter installed and setup
2. Run the test suite:
   ```bash
   flutter test
   ```
3. For coverage report:
   ```bash
   flutter test --coverage
   ```

SOLID-friendly Design Principles
--------------------------------
Our codebase strictly adheres to SOLID principles:

- **S**ingle Responsibility: Each class has one focused purpose
- **O**pen/Closed: Extensible for new operators without modifying existing code
- **L**iskov Substitution: All operators follow the same contract
- **I**nterface Segregation: Minimal, focused interfaces
- **D**ependency Inversion: UI depends on abstractions

How to Contribute
----------------

We welcome contributions! Here's how you can help:

### Setting Up Development Environment
1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/calculator.git
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Making Changes
1. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. Make your changes
3. Run tests to ensure nothing breaks:
   ```bash
   flutter test
   ```
4. Commit with a descriptive message:
   ```bash
   git commit -m "Add: brief description of your changes"
   ```

### Submitting Changes
1. Push to your fork
2. Create a Pull Request with:
   - Clear description of changes
   - Any related issues
   - Screenshots for UI changes
   - Test coverage for new features

### Contribution Guidelines
- Follow Flutter/Dart style guide
- Add tests for new features
- Update documentation as needed
- Keep commits focused and atomic
- Use meaningful commit messages

### Need Help?
- Open an issue for bugs or feature requests
- Ask questions in discussions
- Check existing issues and PRs

### What You Can Contribute

We have several exciting areas where you can make meaningful contributions:

#### 1. Parentheses Support
The calculator currently tokenizes parentheses but doesn't interpret them. You can help by:

- Adding recursive descent parsing for nested expressions
- Writing comprehensive tests for parentheses handling
- Updating the UI to support parentheses input



#### 2. Negative Numbers Support
Enhance the calculator's handling of negative numbers by:
- Implementing a proper unary minus operator
- Updating the expression validator for negative number input
- Adding tests for negative number edge cases
- Improving the UI for negative number display

#### 3. Mathematical Functions
Help expand the calculator's capabilities by adding:
- Trigonometric functions (sin, cos, tan)
- Logarithmic functions (log, ln)
- Power functions (sqrt, cube root)
- Constants (π, e)

#### 4. User Interface Improvements
- Add scientific calculator mode
- Implement history feature
- Add memory functions (M+, M-, MR, MC)
- Improve accessibility features


Each contribution should:
- Follow the existing design patterns
- Include comprehensive tests
- Update relevant documentation
- Consider edge cases and error handling

Pick an area that interests you and check our issues page for related tasks or create a new issue to discuss your implementation approach.
