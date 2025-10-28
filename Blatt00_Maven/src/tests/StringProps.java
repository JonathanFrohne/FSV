package tests;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Assumptions;

import net.jqwik.api.ForAll;
import net.jqwik.api.Property;

public class StringProps {
	@Property
	void testConcat(@ForAll String x) {
		Assertions.assertTrue((x + "").length() == x.length());
		Assertions.assertTrue(("" + x).length() == x.length());
		Assertions.assertTrue((x + x).length() == x.length() * 2);

	}

	@Property
	void testConcatWithTwo(@ForAll String x, @ForAll String y, @ForAll int i) {
		Assumptions.assumeTrue(x != null);
		Assumptions.assumeTrue(y != null);
		Assumptions.assumeTrue(i < x.length() + y.length() && i >= 0);
		Assertions.assertTrue((x + y).length() == x.length() + y.length());
		
		Assertions.assertTrue((x + y).charAt(i) == (i < x.length() ? x.charAt(i) : y.charAt(x.length() - i + 1)));
	}
}
