import Mathlib

example (a b : ℝ) : a + b = b + a := by ring

example (x : ℝ) : (x + 1)^2 = x^2 + 2*x + 1 := by ring

example (a b : ℝ) : (a + b)*(a - b) = a^2 - b^2 := by ring

-- 1. A fresh ring identity (your choice, not a Day 2 repeat)
example (x y : ℝ) : (x + y) ^ 2 = x ^ 2 + 2 * x * y + y ^ 2 := by ring

-- 2. An inequality by linarith
example (a b : ℝ) (h : a ≤ b) : a + 1 ≤ b + 1 := by linarith

-- 3. A fraction identity: field_simp
example (a : ℝ) (ha : a ≠ 0) : a / a = 1 := by field_simp

-- 4. A sum by induction (write the base case and step explicitly first)
example (n : ℕ) : (∑ i ∈ Finset.range (n + 1), (i : ℝ)) = n * (n + 1) / 2 := by
  induction n with
  | zero => simp
  | succ n ih =>
    simp [Finset.sum_range_succ, ih];
    ring;

-- 5. Geometric series closed form via geom_sum_eq
theorem geom_series_closed_form (x : ℝ) (hx : x ≠ 1) (n : ℕ) :
    (∑ i ∈ Finset.range n, x ^ i) = (x ^ n - 1) / (x - 1) := by
  rw [geom_sum_eq hx n]


-- FM statement
theorem accum_factor_succ (i : ℝ) {n : ℕ} : (1 + i)^(n + 1) = (1 + i)^n * (1 + i) := pow_succ _ _

-- Discount factor v = (1 + i)⁻¹
theorem discount_factor_mul (i : ℝ) (hi : i ≠ -1) :
    (1 + i)⁻¹ * (1 + i) = 1 := by
  have h1 : (1 + i : ℝ) ≠ 0 := by
    intro h
    apply hi
    linarith
  exact inv_mul_cancel₀ h1

theorem discount_factor_pow (i : ℝ) (hi : i ≠ -1) (n : ℕ) :
    ((1 + i)⁻¹) ^ n = ((1 + i) ^ n)⁻¹ := by
  rw [inv_pow]

#print axioms geom_series_closed_form
#print axioms accum_factor_succ
#print axioms discount_factor_mul
#print axioms discount_factor_pow
