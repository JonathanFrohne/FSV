package tests;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.opentest4j.AssertionFailedError;

public class SimpleTests {
	static int a[] = { 1, 4, 2, 3, 5, 7, 4, 9, -1 };

	@Test
	void testMax() {
		Assertions.assertEquals(1, Simple.max(a, 0, 1));
		Assertions.assertEquals(3, Simple.max(a, 2, 4));
		Assertions.assertEquals(9, Simple.max(a, 0, a.length));

		Assertions.assertThrows(AssertionFailedError.class, () -> Simple.max(a, 15, 1500));
		Assertions.assertThrows(AssertionFailedError.class, () -> Simple.max(null, 15, 1500));
		Assertions.assertThrows(AssertionFailedError.class, () -> Simple.max(a, 3, 2));
		Assertions.assertThrows(AssertionFailedError.class, () -> Simple.max(a, -10, 1500));
		Assertions.assertThrows(AssertionFailedError.class, () -> Simple.max(a, 0, -5));
	}

	@Test
	void testAbs() {
		Assertions.assertEquals(0, Simple.abs(0));
		Assertions.assertEquals(10, Simple.abs(10));
		Assertions.assertEquals(10, Simple.abs(-10));
		// Assertions.assertEquals(Integer.MAX_VALUE, Simple.abs(Integer.MIN_VALUE));
	}

	@Test
	void testFib() {
		Assertions.assertEquals(0, Simple.fib(-1));
		Assertions.assertEquals(0, Simple.fib(0));
		Assertions.assertEquals(1, Simple.fib(1));
		Assertions.assertEquals(1, Simple.fib(2));
		Assertions.assertEquals(2, Simple.fib(3));
		Assertions.assertEquals(3, Simple.fib(4));
		Assertions.assertEquals(5, Simple.fib(5));
		Assertions.assertEquals(8, Simple.fib(6));
		Assertions.assertEquals(13, Simple.fib(7));
	}
}
