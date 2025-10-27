import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TestClass {

	@Test
	void test() {
		assertTrue(System.getProperty("java.version").startsWith("17."),
				"Es ist eine andere als die getestete Java-Version installiert");
	}

}