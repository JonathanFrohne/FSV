class PhoneBook implements IPhoneBook {

	private static final int X = 4;
	private static final int Y = 4;
	private final int[][] data;

	PhoneBook() {
		data = new int[X][Y];
	}

	private int hash(String name) {
		int h = 0;
		for (int i = 0; i < name.length(); i++) {
			h += name.charAt(i);
		}
		return h % X;
	}

	@Override
	public int[] lookupName(String name) {
		int x = hash(name);
		int[] entries = data[x];

		int count = 0;
		for (int y = 0; y < Y; y++) {
			if (entries[y] != 0)
				count++;
		}

		int[] result = new int[count];
		int index = 0;
		for (int y = 0; y < Y; y++) {
			if (entries[y] != 0) {
				result[index] = entries[y];
				index++;
			}
		}

		return result;
	}

	@Override
	public void addEntry(String name, int number) {
		int x = hash(name);
		int[] entries = data[x];

		for (int y = 0; y < Y; y++) {
			if (entries[y] == 0) {
				entries[y] = number;
				return;
			}
		}
	}

	@Override
	public void removeEntry(String name, int number) {
		int x = hash(name);
		int[] entries = data[x];

		for (int y = 0; y < Y; y++) {
			if (entries[y] == 0)
				return;
			if (entries[y] == number) {
				entries[y] = 0;
				return;
			}
		}
	}
}
