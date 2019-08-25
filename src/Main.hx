package;

import motion.easing.Cubic;
import motion.easing.Back;
import motion.easing.Elastic;
import motion.easing.Quart;
import motion.easing.Bounce;
import motion.easing.Expo;
import motion.easing.Quad;
import motion.easing.Sine;
import haxe.Timer;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import motion.Actuate;

class Main extends Sprite
{
	var image:Bitmap;
	var index:Int = 0;
	var max:Int = 3;
	public function new()
	{
		super();
		stage.color = 0x7f7f7f;
		//stage.color = 0;
		image = new Bitmap();
		image.smoothing = true;
		addChild(image);
		change(0,gallery);
		//events
		stage.addEventListener(Event.RESIZE,resize);
	}
	private function gallery()
	{
		Actuate.tween(image,0.6,{alpha:0},false).onComplete(function(_)
		{
			change(++index,function()
			{
				trace("index " + index);
				Actuate.tween(image,0.4,{alpha:1},false).onComplete(function(_)
				{
					gallery();
				}).ease(Expo.easeOut);
				switch (index)
				{
					case 0:
					//baby
					Actuate.tween(image,2,{x:image.x,y:image.y,width:image.width,height:image.height});
					//image.x += -image.width * 0.5 * 0.5;
					//image.y += -image.height * 0.5 * 0.5;
					image.width *= 0.5;
					image.height *= 0.5;
					case 1:
					//baker
					Actuate.tween(image,2,{y:image.y}).ease(Bounce.easeOut);
					image.y = -image.height;
					case 2:
					//michael
					Actuate.tween(image,2.2,{y:image.y}).ease(Expo.easeOut);
					image.y = stage.stageHeight;
					case 3:
					//sword lady
					Actuate.tween(image,4,{x:image.x,rotation:0}).ease(Expo.easeOut);
					image.x = stage.stageWidth;
					image.rotation = 15;
				}
				if (index >= max) 
				{
					trace("max index");
					index = -1;
				}
			});
		}).delay(3 * 1).ease(Expo.easeOut);
		
	}
	private function change(index:Int,finish:Void->Void)
	{
		Assets.loadBitmapData("assets/" + index + ".png").onComplete(function(bmd:BitmapData)
		{
			image.bitmapData = bmd;
			image.width = image.bitmapData.width;
			image.height = image.bitmapData.height;
			resize(null);
			finish();
		});
	}
	private function resize(_)
	{
		//image
		var ratio:Float = image.width/image.height;
		//trace("ratio " + ratio);
		//trace("stage w " + stage.stageWidth + " h " + stage.stageHeight);
		//trace("width " + image.width + " height " + height);
		image.height = stage.stageHeight * 1;
		image.width = image.height * ratio;
		if (image.width > stage.stageWidth)
		{
			image.height = stage.stageWidth/ratio;
			image.width = stage.stageWidth;
		}
		trace("scale " + image.scaleX + " " + image.scaleY);
		center();
	}
	private function center()
	{
		image.x = (stage.stageWidth - image.width)/2;
		image.y = (stage.stageHeight - image.height)/2;
	}
}
