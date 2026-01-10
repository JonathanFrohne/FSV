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

class String {
  // model variable
  ghost var content: seq<char>

  // class attribtues of the implementation
  var chars: array<char>
  var start: int
  var end: int

  ghost predicate inv()
    reads this, chars
  {
    0 <= start <= end <= chars.Length && content == chars[start..end]
  }

  constructor(chars: array<char>, start: int, end: int)
    // requires TODO: what are valid input parameters?
    // ensures  TODO: how content depends on the input parameters
    requires chars != null
    requires 0 <= start <= end <= chars.Length
    ensures inv()
  {
    this.chars := chars;
    this.start := start;
    this.end   := end;
    this.content := chars[start..end];
  }

  method Length()
    returns (n: int)
    requires inv()
    ensures n == |content|
  {
    return end - start;
  }

  // Note: this helper lemma is needed so that Dafny can recognize some proofs
  lemma helper(at: int, k: int)
    requires 0 <= at <= k <= end-start
    requires inv()
    ensures  content[at..k] == chars[start+at..start+k]
  {
    if (at < k) { helper(at, k-1); }
  }

  method Substring(at: int, length: int)
    returns (result: String)
    requires 0 <= at && 0 <= length && at + length <= |content|
    ensures fresh(result)
    requires inv()
    ensures result.inv()
    ensures result.content == this.content[at..at+length]
  {
    helper(at, at+length);
    return new String(chars, start + at, start + at + length);
  }

  method Concat(that: String)
    returns (result: String)
    requires inv() && that.inv()
    ensures result.inv()
    // ensures result.content == TODO
  {
    var m := this.Length();
    var n := that.Length();

    var newchars := new char[m+n];
    var newstart := 0;
    var newend   := m + n;

    arraycopy(chars,0,newchars,0,m);
    arraycopy(that.chars,0,newchars,m,n);

    return new String(newchars, newstart, newend);
  }

  method ContainsAt(that: String, at: int)
    returns (result: bool)
    requires inv() && that.inv()
    requires 0 <= at <= |that.content|
    // ensures result <==> at + |that.content| <= |this.content| && TODO: the correct subrange of this.content equals that.content
  {
    var m := this.Length();
    var n := that.Length();

    result := false; // TODO: remove this

    // if TODO {
    //   var eq := arraycompare(TODO);
    //   helper(at, at+n);
    //   return eq;
    // } else {
    //   return false;
    // }
  }
}
