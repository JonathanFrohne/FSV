 method Add(a: int, b: int) returns (z: int)
  requires b >= 0 // Ensure b is non-negative to avoid infinite loops
  ensures z == a + b  // The result must be equal to a + b
{
  var y := a;
  var bloc := b;
  while (bloc > 0)
    invariant y + bloc == a + b // The sum of y and bloc must always equal a + b
    decreases bloc  // required to proof termination
  {
    y := y + 1;
    bloc := bloc - 1;
  }
  return y;
}

method Main()
{
  // Example: Call Add with a=5 and b=3
  var result := Add(5, 3);
  print "The result of Add(5, 3) is: ", result, "\n";


  result := Add(-5, 3);
  print "The result of Add(-5, 3) is: ", result, "\n";
}