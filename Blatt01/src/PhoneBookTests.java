import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/*
 * Initial results: 81% covered, removeEntry not covered
 */
public class PhoneBookTests {

	private IPhoneBook book;

	@BeforeEach
	void setup() {
		// Initialization
		book = new PhoneBook();
	}

	@Test
	void addEntry_addTwoNumbersToSameKey_bothAreStored() {
		// Run method to be tested
		book.addEntry("Hilbert", 1234);
		book.addEntry("Hilbert", 7777);

		// Check result
		int[] numbers = book.lookupName("Hilbert");
		assertElements(numbers, 1234, 7777);
	}

	@Test
	void removeEntry_thatExists() {
		book.addEntry("Hilbert", 7777);
		book.removeEntry("Hilbert", 7777);
	}

	@Test
	void removeEntry_thatDoesnotExist() {
		book.removeEntry("Herbert123", 7777);
	}

	@Test
	void leadingToAnException() {
		book.addEntry(null, 1);
	}

	void assertElements(int[] array, int... elements) {
		Assertions.assertArrayEquals(array, elements);
	}
}
