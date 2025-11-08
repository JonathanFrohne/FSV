public interface IPhoneBook {
	
	int[] lookupName(String name);

	void addEntry(String name, int number);

	void removeEntry(String name, int number);
}
