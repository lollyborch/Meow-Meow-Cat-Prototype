package  {
	
	import flash.display.MovieClip;
	
	
	public class path extends MovieClip {
		
		//variable for how many dots in a row for each level
		public var dotNum:Number;
		
		//public var dotNum:Number;
		
		//random number returns string with name of colour for movement
		public var dotColour:String;
		
		//chooses the frame number where the different colour dots are kept
		public var dotFrame:Number;
		
		//start X position
		public var startX:int = 370;
		//start Y position
		public var startY:int = 420;
		
		//space between dots in a row
		public var padding:int = 195;
		
		//space between dots in a row + a bit more
		public var paddingMore:int = 200;
		
		public function path(num) {
			// constructor code
			this.dotNum = num;
			setColour();
			//trace(dotColour);
			
			//goes to the frame number spcified in setColour function
			this.gotoAndStop(this.dotFrame);
			
			this.y = startY;
			this.x = startX + (num * padding);
			//trace(this.x);
			
		}
		
		public function setColour()
		{
			//creates random number from 1-4
			this.dotFrame = Math.floor(Math.random() * 4) + 1;
			//four cases represent 4 frames with 4 different colours
			switch(this.dotFrame)
			{
				case 1:
					//assigns string with colour name
					this.dotColour = "green";
					//trace("The colour is green");
					break;
				case 2:
					this.dotColour = "blue";
					//trace("The colour is blue");
					break;
				case 3:
					this.dotColour = "purple";
					//trace("The colour is purple");
					break;
				case 4:
					this.dotColour = "red";
					//trace("The colour is red");
					break;
				default:
					this.dotColour = "error"
					trace("No colour");
					break;
			}
			
		}
		
		public function moveDot()
		{
			//changes x position of dot by amount specified in padding
			this.x -= padding;
		}
	}
	
}
