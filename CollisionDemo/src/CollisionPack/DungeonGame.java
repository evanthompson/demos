package CollisionPack;

import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;

import CollisionPack.DungeonMain.Compass;

// Contains all major Game related function
// Ideally, should function with different UIs
public class DungeonGame {
	/* 
	Start Menu Options
	-- New Game, Load Game, Exit Game

	InGame Menu Options
	-- Pause / Resume, View statistics, Save & Exit
	
	InGame Environment
	-- key bindings: Movement, Open Menu
	-- Rules: 	Objects cannot overlap
				Pick up loot on contact
				Kill mobs on contact
				Random mob movement
				Contact with exit loads next floor
				Each Floor must be remembered
	 */
	
	private Hero hero;
	private DungeonFloor level;
	public int UNIT;
	
	public DungeonGame() {
		level = new DungeonFloor();
		UNIT = level.UNIT_SIZE;
		
		System.out.print("Rocks...");
		for(InanimateObject inan : level.getRocks()) {
			System.out.print(inan.toString());
		}
		System.out.println();
		
		System.out.print("Mobs...");
		for(Mob m : level.getEnemies()) {
			System.out.print(m.toString());
		}
		System.out.println();
		
		// Hero Generation
		hero = new Hero(0, 0, 1, 100);
		place(hero, 1);
	}
	
	public void beginGame() {
		// TODO This is redundant until the project is more fleshed out
		//		Starting menu screens and options need to be implement
		//		first for this method to have a purpose.
	}

	
	// 	Places hero randomly within the bounds of the map
	// 	Collision still needs to be implemented here.
	// 	This method is possibly redundant since a similar one can
	// 	be found within the DungeonFloor object.
	private void place(GameObject obj, int type) {
		int randomY, randomX, upperY, upperX, multiplier;
		upperX = level.MAP_WIDTH - level.UNIT_SIZE;
		upperY = level.MAP_HEIGHT - level.UNIT_SIZE;
		multiplier = (int)(level.MAP_HEIGHT / level.UNIT_SIZE);
		randomY = Math.min((int)(Math.random() * multiplier) * level.UNIT_SIZE, upperY);
		randomX = Math.min((int)(Math.random() * multiplier) * level.UNIT_SIZE, upperX);
		
		obj.setYpos(randomY);
		obj.setXpos(randomX);
	}
	
	// Decision hub for movement
	public void desiredMove(Compass direction) {
		hero.setDirection(direction);
		
		switch(direction) {
			case WEST:	moveWest();
						break;
			case EAST:	moveEast();
						break;
			case NORTH:	moveNorth();
						break;
			case SOUTH:	moveSouth();
						break;
			default:	System.out.println("invalid direction..");
						break;
		}
	}
	
	// TODO Compress all the directional move functions into one
	// Will move hero in the desired direction, as far as one step,
	// unless an obstacle is present, in which the hero is move as
	// far as possible before collision.
	public void moveWest() {
		int lower = hero.getYpos();
		int upper = lower + UNIT;
		int step = 10;
		
		// Check all objects for a possible collision with hero
		for(GameObject g : level.getObjects()) {
			// Is there horizontal overlap?
			if((hero.getXpos() - step) <= g.getXpos() + UNIT) {
				// Is there vertical overlap?
				if((lower >= g.getYpos() && lower < g.getYpos() + UNIT) || 
						(upper > g.getYpos() && upper <= g.getYpos() + UNIT)) {
					// there should be a collision -> move as close as possible
					step = Math.min(step, Math.abs(hero.getXpos() - (g.getXpos() + UNIT)));
					if(step == 0) { break; }
				}
			}
		}
		hero.setXpos(Math.max(0, hero.getXpos() - step));
	}
	
	public void moveEast() {
		int lower = hero.getYpos();
		int upper = lower + UNIT;
		int step = 10;
		
		for(GameObject g : level.getObjects()) {
			// Is there horizontal overlap?
			if((hero.getXpos() + UNIT + step) >= g.getXpos()) {
				// Is there vertical overlap?
				if((lower >= g.getYpos() && lower < g.getYpos() + UNIT) || 
						(upper > g.getYpos() && upper <= g.getYpos() + UNIT)) {
					// there should be a collision -> move as close as possible
					step = Math.min(step, Math.abs((hero.getXpos() + UNIT) - g.getXpos()));
					if(step == 0) { break; }
				}
			}
		}
		hero.setXpos(Math.min(level.MAP_WIDTH - UNIT, hero.getXpos() + step));
	}
	
	public void moveNorth() {
		int lower = hero.getXpos();
		int upper = lower + UNIT;
		int step = 10;
		
		for(GameObject g : level.getObjects()) {
			// Is there vertical overlap?
			if((hero.getYpos() - step) <= g.getYpos() + UNIT) {
				// Is there vertical overlap?
				if((lower >= g.getXpos() && lower < g.getXpos() + UNIT) || 
						(upper > g.getXpos() && upper <= g.getXpos() + UNIT)) {
					// there should be a collision -> move as close as possible
					step = Math.min(step, Math.abs(hero.getYpos() - (g.getYpos() + UNIT)));
					if(step == 0) { break; }
				}
			}
		}
		hero.setYpos(Math.max(0, hero.getYpos() - step));
	}
	
	public void moveSouth() {
		int lower = hero.getXpos();
		int upper = lower + UNIT;
		int step = 10;
		
		for(GameObject g : level.getObjects()) {
			// Is there vertical overlap?
			if((hero.getYpos() + UNIT + step) >= g.getYpos()) {
				// Is there vertical overlap?
				if((lower >= g.getXpos() && lower < g.getXpos() + UNIT) || 
						(upper > g.getXpos() && upper <= g.getXpos() + UNIT)) {
					// there should be a collision -> move as close as possible
					step = Math.min(step, Math.abs((hero.getYpos() + UNIT) - g.getYpos()));
					if(step == 0) { break; }
				}
			}
		}
		hero.setYpos(Math.min(level.MAP_HEIGHT - UNIT, hero.getYpos() + step));
	}
	
	// TODO A currently redundant function
	// Checks one step in all directions of the hero
	// for possible collision
	public boolean checkMove(int newY, int newX) {
		Point topLeft = new Point(newX, newY);
		Point topRight = new Point(newX + UNIT, newY);
		Point bottomLeft = new Point(newX, newY + UNIT);
		Point bottomRight = new Point(newX + UNIT, newY + UNIT);
		
		for(GameObject g : level.getObjects()) {
			Rectangle area = new Rectangle(g.getXpos(), g.getYpos(), UNIT, UNIT);
			if(area.contains(bottomRight) || area.contains(bottomLeft) ||
					area.contains(topRight) || area.contains(topLeft)) {
				System.out.println("Collision Detected..");
				return false;
			}
		}
		return true;
	}
	
	// Get Methods //////////
	public DungeonFloor getFloor() { return level; }
	public Hero getHero() { return hero; }
}
