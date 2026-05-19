---
description: OOP design patterns, SOLID principles, and refactoring techniques for Ruby, JavaScript, and TypeScript. Use when designing classes, refactoring code, applying OOP patterns, or discussing software architecture. Triggers on: OOP, SOLID, refactoring, design patterns, polymorphism, factory, inheritance, code smell, clean code, architecture, DDD, hexagonal.
---

# OOP Design Patterns

*Synthesized from: 99 Bottles of OOP (Ruby + JS editions), Functional Design Patterns for Express, SOLID with TypeScript*

---

## Core Philosophy

**Boring & obvious > clever.** Code should be readable first. Complexity is only justified when requirements actually change—not as anticipatory insurance.

**The fundamental tension**: coupling vs. cohesion. Minimize coupling (interdependency) while maximizing cohesion (focused responsibility).

---

## Starting Point: Shameless Green

Start with the simplest, most concrete solution that passes tests—even with duplication.

**Why**: Concrete code is easy to understand. Abstractions guessed before requirements arrive are usually wrong and expensive to change.

**Rule**: Refactor only when actual requirements change. Change reveals which code needs flexibility.

```ruby
# Shameless Green: concrete, duplicated, readable
def verse(number)
  case number
  when 0
    "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  when 1
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"
  else
    "#{number} bottles of beer on the wall, #{number} bottles of beer.\n" \
    "Take one down and pass it around, #{number - 1} bottles of beer on the wall.\n"
  end
end
```

---

## The Flocking Rules (Incremental Refactoring)

Apply these rules one step at a time. Never skip ahead.

1. **Select** the things that are most alike
2. **Find** the smallest difference between them
3. **Make** the simplest change that removes that difference
4. Run tests. Repeat.

**Key insight**: DRY out *difference*, not just sameness. The concept that varies is what deserves a name.

**When conditionals appear 3+ times, an abstraction is missing.**

---

## SOLID Principles

### S — Single Responsibility

One reason to change. When a class handles multiple concerns, split it.

```typescript
// BAD: Order knows how to print invoices
class Order {
  addItem(price: number): void { ... }
  calculateTotal(): number { ... }
  printInvoice(): void { ... } // wrong place
}

// GOOD: Separate concerns
class Order {
  addItem(price: number): void { ... }
  calculateTotal(): number { ... }
}

class InvoicePrinter {
  print(order: Order): void { ... }
}
```

### O — Open/Closed

Open for extension, closed for modification. New behavior via new code, not editing old code.

**Decision**: Can I add this feature without changing existing code? If no → identify smells → fix them first.

```ruby
# BAD: Adding six-pack requires modifying existing case
case number
when 0 then "no more"
when 1 then "1"
when 6 then "1"  # had to edit here
else number.to_s
end

# GOOD: New class, no existing code touched
class BottleNumber6 < BottleNumber
  def quantity = "1"
  def container = "six-pack"
end
```

### L — Liskov Substitution

Subtypes must be substitutable for their base type without breaking the contract.

**Violation signal**: checking `is_a?` or `instance_of?` in the caller.

```typescript
// Swap implementations freely — both honor the contract
interface UserRepository {
  save(user: User): Promise<void>;
  getByEmail(email: Email): Promise<User | null>;
}

class PostgresUserRepository implements UserRepository { ... }
class InMemoryUserRepository implements UserRepository { ... } // for tests
```

### I — Interface Segregation

Don't force classes to implement methods they don't use. Split fat interfaces.

```typescript
// BAD: BasicPrinter forced to throw on unused methods
interface WarehouseDevice {
  printLabel(id: string): void;
  scanBarcode(): string;
  packageItem(id: string): void;
}

// GOOD: Segregated
interface LabelPrinter { printLabel(id: string): void; }
interface BarcodeScanner { scanBarcode(): string; }
```

### D — Dependency Inversion

High-level modules depend on abstractions, not concretions.

```typescript
// BAD: Hardwired to SendGrid
class OrdersService {
  private emailService = new SendGridEmailService();
}

// GOOD: Depends on interface, receives via injection
class OrdersService {
  constructor(private emailService: EmailService) {}
}

// Production
new OrdersService(new SESMailService());
// Test
new OrdersService(new MockEmailService());
```

---

## Replace Conditional with Polymorphism

The key move when conditionals grow or multiply.

**Process**:
1. Create base class with default behavior
2. Create subclass for each variant, overriding only what differs
3. Add factory to select the right class
4. Callers send messages — never check types

```ruby
class BottleNumber
  def quantity = number.to_s
  def container = "bottles"
  def action = "Take one down and pass it around"
  def successor = BottleNumber.for(number - 1)
end

class BottleNumber0 < BottleNumber
  def quantity = "no more"
  def action = "Go to the store and buy some more"
  def successor = BottleNumber.for(99)
end

class BottleNumber1 < BottleNumber
  def container = "bottle"
  def action = "Take it down and pass it around"
end
```

---

## Factory Pattern

Isolate all variant-selection logic in one place. Message senders never name concrete classes.

```ruby
class BottleNumber
  def self.for(number)
    case number
    when 0 then BottleNumber0
    when 1 then BottleNumber1
    when 6 then BottleNumber6
    else        BottleNumber
    end.new(number)
  end
end
```

```typescript
class PaymentFactory {
  static create(provider: string): PaymentProvider {
    switch (provider) {
      case 'stripe': return new StripePayment();
      case 'paypal': return new PayPalPayment();
      default: throw new Error(`Unknown provider: ${provider}`);
    }
  }
}
```

**Rule**: Conditionals don't disappear — they move to the factory, where they belong.

---

## Common Code Smells

| Smell | Signal | Fix |
|-------|--------|-----|
| Duplication | Same pattern 3+ times | Extract method / class |
| Data clump | Fields that always appear together | Extract concept/object |
| Switch on type | Case/if-else on category | Replace with polymorphism |
| Feature envy | Method uses another object's data heavily | Move method to that object |
| God class | One class does everything | Split by responsibility |
| Primitive obsession | Strings/ints instead of domain objects | Extract value objects |

---

## Value Objects (DDD)

Compared by value, not identity. Validate on construction.

```typescript
class Email {
  constructor(private value: string) {
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
      throw new Error("Invalid email");
    }
  }

  equals(other: Email): boolean {
    return this.value === other.value;
  }

  toString(): string {
    return this.value;
  }
}
```

---

## Express/Node.js Middleware Patterns

### Policies & Enforcers (Authorization)

Separate the rule (policy) from the response (enforcer).

```javascript
// Policy: pure function, trivially testable
const updateEmailPolicy = (req) =>
  req.user.id === findEmailById(req.params.id).authorId;

// Enforcer: handles HTTP concerns
const enforce = (policy) => (req, res, next) => {
  if (policy(req)) next();
  else res.sendStatus(403);
};

// Usage
emailsRouter.patch('/:id', enforce(updateEmailPolicy), handler);
```

### Middleware Factories (Currying)

Inject dependencies at creation time, not usage time.

```javascript
// Without currying: hardwired dependency
const basicAuth = (req, res, next) => {
  const user = findUserByCredentials(req); // hardwired
};

// With currying: injected dependency
const basicAuth = (findUser) => (req, res, next) => {
  const user = findUser(req);
  if (!user) return res.sendStatus(401);
  req.user = user;
  next();
};

// Production
app.use(basicAuth(db.findUserByCredentials));
// Test
app.use(basicAuth(mockFindUser));
```

### Router Extraction

Prevent single files from growing unbounded. Each concern gets its own router.

```javascript
// routes/emails.js
const router = express.Router();
router.get('/', listEmails);
router.post('/', createEmail);
export default router;

// index.js
app.use('/emails', emailsRouter);
app.use('/users', usersRouter);
```

---

## Hexagonal Architecture

Domain logic at the center. External concerns (DB, HTTP, messaging) at the edges via interfaces (ports).

```
[HTTP Adapter] → [Port: UserRepository interface] ← [Domain: User aggregate]
[Postgres Adapter] → [Port: EmailService interface] ← [Application Service]
```

**Rule**: External code depends on domain contracts. Domain never depends on infrastructure.

**Benefit**: Swap database, email provider, or API layer without touching business logic.

---

## TDD: Red-Green-Refactor

1. **Red**: Write a failing test (proves the feature doesn't exist)
2. **Green**: Write the *simplest* code that passes ("quick green excuses all sins")
3. **Refactor**: Improve design with tests as safety net

**Tests must encode WHY behavior matters, not just WHAT it does.**

**If tests are hard to write**: the design has too much coupling — fix the design, not the tests.

---

## Design Principles Quick Reference

| Principle | Rule |
|-----------|------|
| DRY | Don't repeat logic — but not prematurely |
| YAGNI | Build what's needed now, not what might be needed |
| KISS | Simplest solution that works |
| Law of Demeter | Tell, don't ask. `user.deductFee(10)` not `user.account.balance.deduct(10)` |
| Composition > Inheritance | Default to composition; inherit only for substitutability |

---

## Refactoring Decision Checklist

Before refactoring working code, ask:
1. Is there code that bothers me? (intuition signal)
2. Can I articulate *why*? (conscious judgment)
3. Is the code open to the new requirement? If not → identify smells → fix first
4. Does fixing it pay for itself in maintainability?

**Never refactor for**: code style alone, hypothetical future needs, or intellectual satisfaction without benefit.
