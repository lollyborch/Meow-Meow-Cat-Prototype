package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import flash.text.*;
	
	
	public class main extends MovieClip {
		
		var playerCat;
		var gameOverText;
		
		//New IP3 arrow var
		var arrowSymbol;
		
		
		var checkGameOver:Boolean = false;

		
		//sound variables
		var moveSound;
		var bgSound;
		var errorSound;
		
		//defines number of dots in level
		public var level1DotsNumber:int = 25;
		
		//New for IP3 - tracks HighScores - starts at 0, high score can't be negative
		//high score keeper
		public var highScoreKeeper:int = 0;
		
		//empty array to add dot (symbol) to and colour information (string)
		public var level1Array:Array = new Array();
		
		public var level1Colours:Array = new Array();
		//padding between dots
		public var arrayPadding:int = 175;
		
		//countdown timer
		//use this when changing background from sunny to night time
		//level1Timer and level1TimerStr need to be same number
		public var level1Timer:int = 25;
		public var level1TimerStr:String = "25";
		public var myTimer:Timer = new Timer(1000,level1Timer); 
		
		//stopwatch counts up
		//public var myTimer:Timer=new Timer(1000,0);
		//public var level1TimerStr:String = "0";
		
		//background colour vars
		public var rectangle:Shape = new Shape;
		public var startColour:uint = 0xffe042;
		//colours are stepped through to indicate 'sunset' with timer increments
		//NEW for IP3
		public var step20Colour:uint = 0xeb9c47;
		public var step15Colour:uint = 0xe57c5d;
		public var step10Colour:uint = 0xcb7698;
		public var step5Colour:uint = 0x433e89;
		public var endColour:uint = 0x003;
		
		public var guessCounter:int = 0;

		
		public function main() {
			// constructor code
			
			loadSounds();
			startGame();
			
			
		}
		
		
		public function startGame()
		{
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, moveDots);

			//countdown
			//myTimer.addEventListener(TimerEvent.TIMER, onTimer);
			
			//stopwatch
			//NEW for IP3 - counts down instead of up
			timer_text.text = level1TimerStr;
			
			myTimer.addEventListener(TimerEvent.TIMER, stopWatch);
			//myTimer.addEventListener(TimerEvent.TIMER, changeBackgroundColour);
			//play button
			start_btn.addEventListener(MouseEvent.CLICK, startClock);
			//pause button
			//stop_btn.addEventListener(MouseEvent.CLICK, stopClock);
			//end button
			replay_btn.addEventListener(MouseEvent.CLICK, resetGame);
			//changes background on timer event
			//changeBackgroundColour();
		}
		
		//New IP3 add arrow
		public function addArrow()
		{
			arrowSymbol = new arrow(368,540);
			stage.addChild(arrowSymbol);
			trace("arrow added");
		}
		
		//New IP3 remove arrow
		public function removeArrow()
		{
			stage.removeChild(arrowSymbol);
			trace("arrow removed");
		}
		
		
		public function drawBackground(colourvar)
		{
			//removeChild(rectangle);
			//draw rectangle with start colour
			rectangle.graphics.beginFill(colourvar); 
			//x and y are at start, dimensions fill whole stage
			rectangle.graphics.drawRect(0, 0, 1024,768); 
			rectangle.graphics.endFill(); 
			//addChild(rectangle); 
			this.addChildAt(rectangle,0);
			
		}
	
		
		public function setupPlayerCat() 
		{
			//adapted from pong tutorial
			//create the cat and add it to the stage specifying x and y position
			playerCat = new player(175,410);
			//puts cat ontop of dots
			
			stage.addChild(playerCat);
		}

		
		public function loadSounds()
		{
			//loads in sound using MMCAudioClip class
			moveSound = new MMCAudioClip("pickup");
			//trace(moveSound.clipName);
			//Pickup by timgormly (Attribution 3.0 Unported (CC BY 3.0))
			//https://www.freesound.org/people/timgormly/sounds/170170/
			errorSound = new MMCAudioClip("bump");
			//trace(moveSound.clipName);
			//Bump by timgormly (Attribution 3.0 Unported (CC BY 3.0))
			//https://www.freesound.org/people/timgormly/sounds/170141/
			bgSound = new MMCAudioClip("miraclepark");
			//trace(bgSound.clipName);
			//Miracle Park from Playonloop.com
			//www.playonloop.com/2014-music-loops/miracle-park/ 
			//CC-BY 3.0 License  


		}
		
		//createpath() and moveDots() adapted from code worked on with tutor
		public function createPath()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, moveDots);
			//iterate from 0 to the number of dots needed
			for (var i:int = 0; i < level1DotsNumber; i++)
			{
				//uses path class to create dot in new variable newDot
				var newDot:Object = new path(i);
				//adds the dot to the array for Level 1
				level1Array.push(newDot);
				level1Colours.push(newDot.dotColour);
				
				//creates number variable to access array by index
				//-1 to account for 0
				var lastDot:int = (level1Array.length - 1);
				//add the last object (dot) to the stage
				stage.addChild(level1Array[lastDot]);
				//trace(level1Array[lastDot]);
			}
			//trace(level1Array);
			//trace(level1Colours);
			
			
		}
		
		public function removePath()
		{
			//for use in timer 'reset' button
			//removes game over text from screen
			if (checkGameOver == false)
			{
				trace("gameover is not on stage");
			}
			else
			{
				//trace("gameover is on stage");
				stage.removeChild(gameOverText);
				//trace("gameover has been removed");
				checkGameOver = false;
			}
			
			//stage.removeChild(gameOverText);
			
		}

		public function moveDots(e:KeyboardEvent):void
		{
			
			var selectedColour = convertKeyCodetoColour(e.keyCode);
			if (selectedColour == "error")
			{
				trace("please use the arrow keys only");
			}
			else
			{
				if (selectedColour == level1Colours[guessCounter])
				{
					//trace("got it right");
					
					for (var i:int = 0; i < level1DotsNumber; i++)
					{
						//move the dot by the amount of padding using movedot function
						level1Array[i].moveDot();
						
						//trace("move " + j);
					}
					//trace("remove dot now");
					//stage.removeChild(level1Array[guessCounter]); // we added this
					//trace("dot removed");
					guessCounter++;
					moveSound.playMMCAudioClip();
					
				}
				else
				{
					trace("guess again");
					errorSound.playMMCAudioClip();
					
					//var myTextBox:TextField = new TextField();    
					//myTextBox.text = "Hello world!";    
					//addChild(myTextBox);  
					//myTextBox.x = 500;    
					//myTextBox.y = 700; 
					
				}
			}
			
			if (guessCounter == level1Colours.length)
			{
				//trace("end game");
				endGame();
			}
			
		
		}
		
		public function backgroundMusic()
		{
			bgSound.playLoopSound();
		}
		
		public function endGame()
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, moveDots);
			myTimer.stop();
			//prints time to console
			trace(timer_text.text);
			
			//New for IP3 - high score
			// stores player score from timer text
			var newScore = timer_text.text;
			
			//if the new score is higher than the saved high score
			// then new score becomes high score
			
			if (newScore > highScoreKeeper)
			{
				// highScore text field is updated with high score
				highScore.text = timer_text.text + "";
				trace("this is a new high score");
				highScoreKeeper = newScore;
			}
			else
			{
				trace("this is NOT a new high score");
			}
			
			//removes dots from play
			for (var i:int = 0; i < level1DotsNumber; i++)
			{
				stage.removeChild(level1Array[i])
			}
			//adds game over text
			gameOverText = new gameOver(510,610);
			stage.addChild(gameOverText);
			trace("gameover man");
			checkGameOver = true;
			removeArrow();
			//trace(checkGameOver);
			//stop background music
			bgSound.stopLoopSound();
			//trace("stopchannel");
			drawBackground(startColour);
			
		}
		
		public function beginPlay()
		{
			//starts timer
			myTimer.start();
			//adds dots to stage
			createPath();
			//adds cat to stage
			setupPlayerCat();
			addArrow();
		}
		
		public function resetStage()
		{

			//clock back to inital time
			resetClock();
			//remove gameover text from stage
			removePath();
			
			//reset arrays and counters
			level1Array = [];
			level1Colours = [];
			guessCounter = 0;
			
			
		}
		
		public function resetGame(e:MouseEvent)
		{
			//resetStage();
			endGame();
			
		}
		
		public function convertKeyCodetoColour(kCode)
		{
			switch (kCode)
			{
				case 38: // up arrow
					return "green";
					break;
				case 39: // right arrow
					return "blue";
					break;
				case 40: // down arrow
					return "purple";
					break;
				case 37: // left arrow
					return "red";
					break;
				default:
					return "error";
					break;
			}
		}
		
	
		//Timer from http://stackoverflow.com/questions/22141106/as-3-flash-countdown-timer-for-game-over-screen
		//Stopwatch code from http://www.ilike2flash.com/2009/07/simple-stopwatch-in-actionscript-3.html
		public function stopWatch(event:TimerEvent):void 
		{
			//count up
			//timer_text.text=String(myTimer.currentCount);
			//timer_text.text=String(myTimer.currentCount);
			
			//New for IP3 countdown timer instead of count up
			//count down
			timer_text.text=String(myTimer.repeatCount - myTimer.currentCount);
			//trace(timer_text.text);
			
			//NEW for IP3 switch draws background at time intervals using colour variables defined at the top
			//trace("change background start")
			//from http://stackoverflow.com/questions/24516267/as3-countdown-timer-color-change
			level1Timer--;
			switch(level1Timer) 
			{
				case 25: //20 seconds
					drawBackground(startColour);
					trace("start colour")
					break;
				case 20: //20 seconds
					drawBackground(step20Colour);
					trace("20 seconds colour")
					break;
				case 15: //20 seconds
					drawBackground(step15Colour);
					trace("15 seconds colour")
					break;
				case 10: //20 seconds
					drawBackground(step10Colour);
					trace("10 seconds colour")
					break;
				case 5: //20 seconds
					drawBackground(step5Colour);
					trace("5 seconds colour")
					break;
				case 0: //20 seconds
					drawBackground(endColour);
					//ends game is timer gets to 0
					endGame();
					trace("end colour")
					break;
			}
		}
		
		function startClock(event:MouseEvent):void 
		{
			
			if (level1Array.length != 0)
			{
				resetStage();
				//remove gameover text from stage
				//removePath();
				beginPlay();
			}
			else
			{
				beginPlay();
				
			}
			backgroundMusic();
			
		}

		function stopClock(event:MouseEvent):void 
		{
			myTimer.stop();
			
			//trace(level1Array.length);
		}

		function resetClock():void 
		{
			myTimer.reset();
			//change to whatever timer countdown is
			timer_text.text=level1TimerStr;
			level1Timer = 25;
			
		}

	}
	
}
