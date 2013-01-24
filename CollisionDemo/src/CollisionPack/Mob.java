package CollisionPack;

// Mob class: things the hero kills for experience and loot
public class Mob extends AnimateObject {
	private int experience;
	private int booty;
	
	public Mob(int x, int y, int type, int h) {
		super(x, y, type, h);
		setExperience((int)(Math.random()*100));
		setBooty((int)(Math.random()*100));
	}
	
	// Set Methods
	public void setExperience(int exp) { experience = exp; }
	public void setBooty(int booty) { this.booty = booty; }
	
	// Get Methods
	public int getExperience() { return experience; }
	public int getBooty() { return booty; }
}
