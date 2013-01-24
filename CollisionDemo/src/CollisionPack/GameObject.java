package CollisionPack;

// Generic object found within the environment of the game board
public abstract class GameObject {
	private int xpos;
	private int ypos;
	private int type;
	
	public GameObject(int x, int y, int t) {
		setXpos(x);
		setYpos(y);
		setType(t);
	}
	
	// Set Methods
	public void setXpos(int x) { xpos = x; }
	public void setYpos(int y) { ypos = y; }
	public void setType(int t) { type = t; }
	
	// Get Methods
	public int getXpos() { return xpos; }
	public int getYpos() { return ypos; }
	public int getType() { return type; }
	
	public String toString() {
		return "(" + xpos + "," + ypos + ")";
	}
}