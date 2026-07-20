# irock-test

A small Rails app for a "Coming soon" waiting list. Visitors submit their name
and email on the landing page and are added to the list; duplicate emails are
handled gracefully and everyone lands on a thank-you page.

## Requirements

- Ruby 3.4.8 (see [`.ruby-version`](.ruby-version))
- Rails 8.1
- PostgreSQL

## Setup

```bash
bundle install
bin/rails db:prepare
```

## Running the app

```bash
bin/rails server
```

Then open http://localhost:3000.

## Tests

```bash
bin/rails test         # models and controllers
bin/rails test:system  # browser tests (requires Chrome)
```

## Project layout

- `app/models/user.rb` — waiting-list entry; validates and normalizes the email.
- `app/controllers/sign_ups_controller.rb` — sign-up flow (new / create / thank you).
- `app/javascript/controllers/email_validation_controller.js` — client-side email validation.
- `lib/scripts/` — standalone coding-exercise scripts, unrelated to the web app
  (excluded from autoloading). See [Exercise scripts](#exercise-scripts).

## Exercise scripts

The files in `lib/scripts/` are self-contained solutions to coding exercises.
Run them directly — they don't need the Rails app.

```bash
# FizzBuzz for 1..100
ruby lib/scripts/2_fizz_buzz.rb

# Replace runs of digits with "NUMBER"  ->  "abc NUMBER def NUMBER NUMBER"
ruby lib/scripts/3_replacer.rb "abc 123 def 345 6"

# Sum a number's digits down to one digit  ->  8
ruby lib/scripts/6_sum_digits.rb 31337
```

- `4_SQL` — SQL query answers; run them against a `salaries` table in any
  Postgres client, e.g. `psql -f lib/scripts/4_SQL`.
- `5_sum.js` — defines `f` so that `f(1, 5)` and `f(1)(5)` both return `6`.
  Run it with Node:

  ```bash
  node -e 'const f=require("./lib/scripts/5_sum.js"); console.log(f(1,5), f(1)(5))'
  ```

## CI

GitHub Actions ([`.github/workflows/ci.yml`](.github/workflows/ci.yml)) runs
security scans (Brakeman, bundler-audit, importmap audit), RuboCop, and the
test and system-test suites on every push and pull request.
