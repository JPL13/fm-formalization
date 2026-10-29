# fm-formalization

Interest-theory mathematics formalized in Lean 4 with Mathlib — accumulation factors, the geometric series behind the annuity formulas, and the foundations they rest on. Every result listed as proved is proved; nothing here relies on `sorry`.

Started Oct 25, 2026, as a one-week from-zero Lean sprint: learn the toolchain, prove the foundations, then formalize the results behind the formulas in my FM Toolkit calculators.

## What's proved

### Interest theory

- **Accumulation factor, recursive form.** For a per-period rate `i : ℝ` and `n : ℕ` periods:
  `(1 + i)^(n + 1) = (1 + i)^n * (1 + i)` — each additional period multiplies the accumulated value by `(1 + i)` once more. Proved from `pow_succ`.
- **Geometric series, closed form.** For `x : ℝ` with `x ≠ 1` and `n : ℕ`:
  `∑ k ∈ Finset.range n, x^k = (x^n - 1) / (x - 1)`, via Mathlib's `geom_sum_eq`. This is the engine of the annuity formulas: an annuity's present value is a geometric series in the discount factor, and this closed form is what turns it into `(1 - v^n) / i`.

A note on the accumulation factor: `n` is a count of periods, so it is a natural number, not a real. With `n : ℝ` the power would be the real power function — and the tempting expansion `1 + n*i + (n(n-1)/2)*i^2` is only the binomial series truncated: exact for `n = 2`, already missing the `i^3` term at `n = 3`. Stating the theorem correctly mattered more than proving it quickly.

### Foundations (the working toolkit, each proved from scratch)

- Commutativity and identities over ℝ: `a + b = b + a`, `(x + 1)^2 = x^2 + 2x + 1`, `(a + b)(a - b) = a^2 - b^2` — by `ring`.
- Order: `a ≤ b → a + 1 ≤ b + 1` — by `linarith`.
- Field identity: `a / a = 1` for `a ≠ 0` — by `field_simp`.
- Sum of the first `n` naturals over ℝ: `∑ k ∈ Finset.range (n + 1), k = n(n + 1) / 2` — by induction, the same pattern the annuity proofs build on.

## Side conditions — read this before the formulas

- **Algebraic condition:** anything involving `(1 + i)⁻¹` needs `i ≠ -1`, equivalently `1 + i ≠ 0`.
- **Financial assumption:** `i > 0` is stronger. It's the assumption under which the interest-theory interpretation holds — not the condition the algebra needs. The formalization keeps the two distinct.

## In progress (not yet claimed)

- Discount factor `v = (1 + i)⁻¹`, with `v * (1 + i) = 1` under `i ≠ -1`.
- Annuity-immediate present value `a-angle-n = (1 - v^n) / i` from the geometric series above; then annuity-due and the loan payment formula.

## Building

```sh
lake build
```

The Lean toolchain is pinned by `lean-toolchain` in the repository root; with `elan` installed, the correct version is fetched automatically. Verify the way a reviewer would: clone into a clean folder and run `lake build` there.

## Background

The author is a mathematician (B.S. Financial Actuarial Mathematics with Specialization in Computing, M.S. Statistics — UCLA) and backend software engineer. The companion products are the FM Toolkit calculators — interest theory and loan amortization — whose formulas this project formalizes.
