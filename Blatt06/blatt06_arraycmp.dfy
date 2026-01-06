method arraycopy<E>(from: array<E>, from_pos: nat,
                   to:   array<E>, to_pos:   nat,
                   length: nat)
  requires from_pos + length <= from.Length
  requires to_pos + length <= to.Length
  modifies to

  requires to != from

  // first part: unchanged
  ensures to[..to_pos] == old(to[..to_pos])

  // second part: copied
  ensures to[to_pos..to_pos+length] == from[from_pos..from_pos+length]

  // third part: unchanged
  ensures to[to_pos+length..] == old(to[to_pos+length..])
{
  var i := 0;
  while i < length
    invariant i <= length
    invariant to[..to_pos] == old(to[..to_pos])
    invariant to[to_pos+length..] == old(to[to_pos+length..])
    invariant to[to_pos..to_pos+i] == from[from_pos..from_pos+i]
    decreases length - i
    modifies to
  {
    to[to_pos+i] := from[from_pos+i];
    i := i+1;
  }
}

// Here, <E(==)> is indicates the generic type of elements,
// but we require that elements must be comparable by equality.
// You can ignore this technical detail.
method arraycompare<E(==)>(a: array<E>, a_pos: nat,
                           b: array<E>, b_pos: nat,
                           length: nat)
  returns (eq: bool)
  requires a.Length >= a_pos + length && b.Length >= b_pos + length
  ensures  eq <==> a[a_pos..a_pos+length] == b[b_pos..b_pos+length]
{
  var i := 0;
  var ret := true;
  while i < length
    invariant i <= length
    invariant ret <==> a[a_pos..a_pos+i] == b[b_pos..b_pos+i]
    decreases length - i
  {
    if (a[a_pos+i] != b[b_pos+i]){
      ret := false;
    }
    i := i + 1;
  }
  return ret;
}

method Main()
{
  var source := new int[10][0,1, 2, 3, 4, 5, 6, 7, 8, 9];
  var dest := new int[10];
  arraycopy(source, 0, dest, 0, 10);

  var i := 0;
  print "Copied array: ";
  while i < dest.Length
    decreases dest.Length - i
  {
    print dest[i], " ";
    i := i + 1;
  }
  print "\n";

  var areEqual := arraycompare(source, 0, dest, 0, 10);
  print "Are source and dest equal? ", areEqual, "\n";

  var testing := new int[10][0,1, 2, 2, 2, 5, 6, 7, 8, 9];
  areEqual :=arraycompare(source, 0, testing, 0, 10);
  print "Are source and dest equal on 0 to 10? ", areEqual, "\n";
  areEqual :=arraycompare(source, 0, testing, 0, 5);
  print "Are source and dest equal on 0 to 5? ", areEqual, "\n";
  areEqual :=arraycompare(source, 5, testing, 5, 5);
  print "Are source and dest equal on 5 to 10? ", areEqual, "\n";
}