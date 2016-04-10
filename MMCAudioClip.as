package  {
	
	import flash.display.MovieClip;
	//created following the pong tutorial for sounds
	
	//loading files
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	//playing sounds
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.*; //for the timer
	
	import flash.events.*;
	
	
	public class MMCAudioClip extends MovieClip {
		
		// varibale to help with playing the sound
		public var clipName:String;
		public var clipFile:String;
	
		public var clipAudio:Sound;
		public var clipChannel:SoundChannel;
		
		public var loopChannel:SoundChannel;
		
		public var clipPlaying:Boolean = false;
		public var clipTimer:Timer;
		
		public function MMCAudioClip(fileName) {
			// the constructor class
			clipName = fileName;
			
			//create the file name
			clipFile = "sounds/"+clipName+".mp3";
		
			var mySound = new Sound();
			mySound.load(new URLRequest(clipFile));
			clipAudio = mySound
			
		}
		
		
		public function playMMCAudioClip()
		{
			//plays the sound
			var myChannel:SoundChannel = new SoundChannel();
			myChannel = this.clipAudio.play();
			this.clipChannel = myChannel;
		}
		
		public function playLoopSound()
		{
			var myLoopChannel:SoundChannel = new SoundChannel();
			var trans:SoundTransform = new SoundTransform(0.1, 0);
			myLoopChannel = this.clipAudio.play(0,3,trans);
			this.loopChannel = myLoopChannel;
			
		}
		
		public function stopLoopSound()
		{
			loopChannel.stop();
		}
		
	}
	
}
