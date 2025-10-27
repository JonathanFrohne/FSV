package tests;

import org.junit.jupiter.api.Assertions;

import net.jqwik.api.ForAll;
import net.jqwik.api.Property;
import net.jqwik.api.constraints.DoubleRange;
import net.jqwik.api.constraints.IntRange;

public class SimpleProperties {
	@Property
	void abs(@ForAll int x) {
		Assertions.assertTrue(Simple.abs(x + 1) > Simple.abs(x));
		Assertions.assertTrue(Simple.abs(x) == x || Simple.abs(x) == -x);
	}
	
	
	// 	Oracle
	int fib(int x) {
		if (x <= 0)
			return 0;
		else if (x == 1)
			return 1;
		else
			return fib(x - 1) + fib(x - 2);
	}

	@Property
	void testFib(@ForAll @IntRange(min = 0, max = 10) int n) {
		int actual = Simple.fib(n);
		int expected = this.fib(n);
		Assertions.assertEquals(expected, actual);
	}
	

	@Property
	void sqrt(@ForAll @DoubleRange(min=0, max=100000) double x) {
		double y = Math.sqrt(x);
		double d = Math.abs(x - y * y);
		Assertions.assertTrue(d <= 0.0001);
	}
}
