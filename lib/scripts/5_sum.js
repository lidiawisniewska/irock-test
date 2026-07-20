// Please write a js function: f(1, 5) -> 6, and then f(1)(5) -> 6

function f(a, b) {
  if (b === undefined) {
    return (x) => a + x;
  }
  return a + b;
}