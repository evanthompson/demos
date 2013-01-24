package CollisionPack;

import java.util.ArrayList;

// Contains floor related information, including:
// dimensions of map, rock and mob lists
public class DungeonFloor {
	public final int 	MAP_HEIGHT = 500;
	public final int 	MAP_WIDTH = 500;
	public final int	UNIT_SIZE = 50;
	
	private ArrayList<GameObject> objects; // keeps track of all 'unit' on THIS floor
	private ArrayList<InanimateObject> rocks;
	private ArrayList<Mob> enemies;
	
	// Constructor - initiate lists and place objects
	public DungeonFloor() {
		objects = new ArrayList<GameObject>(20);
		rocks = new ArrayList<InanimateObject>(10);
		enemies = new ArrayList<Mob>(10);
		
		place(3, 10);
		place(2, 5);
	}
	
	// Creates multiple objects of a certain type and places them
	// randomly within the bounds of the board.
	public void place(int type, int amount) {
		int randomY, randomX;

		for(int i = 0; i < amount; i++) {
			int multiplier = (int)(MAP_HEIGHT / UNIT_SIZE);
			randomY = Math.min((int)(Math.random() * multiplier) * UNIT_SIZE, MAP_HEIGHT - UNIT_SIZE);
			randomX = Math.min((int)(Math.random() * multiplier) * UNIT_SIZE, MAP_WIDTH - UNIT_SIZE);
			
			GameObject newObject;
			if(type == 3) {
				newObject = new InanimateObject(randomY, randomX, type);
				rocks.add((InanimateObject) newObject);
				objects.add(newObject);
			}
			else if(type == 2) {
				newObject = new Mob(randomY, randomX, type, 50);
				enemies.add((Mob) newObject);
				objects.add(newObject);
			}
		}
	}
	
	// Searches within the enemies list for a mob with position
	// matching the x/y passed as parameters.
	public int getMobIndex(int y, int x) {
		for(int i = 0; i < enemies.size(); i++) {
			if(enemies.get(i).getXpos() == x && enemies.get(i).getYpos() == y) {
				return i;
			}
		}
		System.out.println("returning -1.."); // for testing purposes
		return -1;
	}
	
	// Removes mob from both lists in which it is contained.
	// This method is used for when a mob dies.
	public void removeMob(Mob enemy) {
		for(Mob m : enemies) {
			if(enemy.equals(m)) {
				System.out.println("Mob: " + enemy.toString() + " is being removed..");
				enemies.remove(m);
				objects.remove(m);
			}
		}
	}
	
	// Get Methods
	public ArrayList<InanimateObject> getRocks() { return rocks; }
	public ArrayList<Mob> getEnemies() { return enemies; }
	public ArrayList<GameObject> getObjects() { return objects; }
}
