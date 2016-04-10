package  {
	
	import flash.display.*;
	
	public class player extends MovieClip{


		public function player(xPosition, yPosition) {
			// constructor code
			//adapted from pong tutorial
			//set the cat on the screen
			this.x = xPosition;
			this.y = yPosition;
			
		}
		
		public function setX(newX)
		{
			//changes x position of cat
			this.x = newX;
		}
		
		public function getX()
		{
			//returns x value for cat
			return this.x;
		}
		

	}
	
}

