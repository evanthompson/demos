package CollisionPack;

import CollisionPack.DungeonMain.Compass;

public class AnimateObject extends GameObject {
	private int maxHealth;
	private int currHealth;
	private int strength;
	private Compass direction;
	
	// Constructor
	public AnimateObject(int x, int y, int type, int h) {
		super(x, y, type);
		maxHealth = currHealth = h;
		strength = 1;
		
		// Choose random starting direction
		// Used for when combat is implemented
		int i = (int)(Math.random() * 3);
		switch(i) {
			case 0:	direction = Compass.NORTH; break;
			case 1:	direction = Compass.SOUTH; break;
			case 2:	direction = Compass.EAST; break;
			case 3:	direction = Compass.WEST; break;
			default: System.out.println(this.getClass().getName() + 
					"direction was not chosen..");
				break;
		}
	}
	
	public void addToMaxHealth(int h) {
		maxHealth += h;
	}
	public void subToMaxHealth(int h) {
		maxHealth -= h;
	}
	
	public void heal(int h) {
		if(currHealth + h > maxHealth) {
			currHealth = maxHealth;
		} else {
			currHealth += h;
		}
	}
	public void damage(int h) {
		if(currHealth - h < 0) {
			currHealth = 0;
		} else {
			currHealth -= h;
		}
	}
	
	// Set Methods
	public void setDirection(Compass dir) { direction = dir; }
	public void setMaxHealth(int h) { maxHealth = h; }
	public void setCurrHealth(int h) { currHealth = h; }
	public void setStrength(int s) { strength = s; }
	
	// Get Methods
	public Compass getDirection() { return direction; }
	public int getMaxHealth() { return maxHealth; }
	public int getCurrHealth() { return currHealth; }
	public int getStrength() { return strength;	}
}
