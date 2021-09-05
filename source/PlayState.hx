package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var SUS:Player;

	private var BFandGF:Bool = false;
	private var BFandGFoff:Bool = false;
	private var Sussy:Bool = false;
	private var SUSSYoff:Bool = false;

	var bg:FlxSprite;
	var ground:FlxSprite;
	var ground2:FlxSprite;
	var wall:FlxSprite;
	var wall2:FlxSprite;

	var BF:FlxSprite;
	var GF:FlxSprite;

	var DEAD:FlxSprite;
	var blackScreen:FlxSprite;

	var MARIO:FlxSprite;
	var PUSSY:FlxSprite;

	override public function create()
	{
		SUS = new Player(657, 300);
		SUS.antialiasing = true;

		FlxG.sound.playMusic('assets/music/BK.mp3');
		#if windows
		FlxG.sound.playMusic('assets/music/BK.ogg');
		#end

		bg = new FlxSprite(0, 0).loadGraphic(Paths.image('stage'));
		bg.antialiasing = true;

		BF = new FlxSprite(291.95, 410.95);
		BF.frames = Paths.getSparrowAtlas('BF');
		BF.animation.addByPrefix('idle', 'BFSMALL', 24);
		BF.animation.play('idle');

		GF = new FlxSprite(576.55, 244.05);
		GF.frames = Paths.getSparrowAtlas('GF');
		GF.animation.addByPrefix('idle', 'GFSMALL', 24);
		GF.animation.play('idle');

		DEAD = new FlxSprite(492.9, 145.75);
		DEAD.frames = Paths.getSparrowAtlas('DEAD');
		DEAD.animation.addByPrefix('idle', 'BF Dead Loop', 24);
		DEAD.animation.play('idle');

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		ground = new FlxSprite(0, 600);
		ground.makeGraphic(1488, 10);
		ground.alpha = 0;

		ground2 = new FlxSprite(0, 0);
		ground2.makeGraphic(1488, 10);
		ground2.alpha = 0;

		wall = new FlxSprite(0, 0);
		wall.makeGraphic(10, 672);
		wall.alpha = 0;

		wall2 = new FlxSprite(1480, 0);
		wall2.makeGraphic(10, 672);
		wall2.alpha = 0;

		add(bg);
		add(ground);
		add(ground2);
		add(wall);
		add(wall2);
		add(SUS);

		FlxG.camera.setScrollBoundsRect(0, 0, 1488, 672, true);
		FlxG.camera.follow(SUS, PLATFORMER);

		SUS.acceleration.y = 600;

		ground.immovable = true;
		ground2.immovable = true;
		wall.immovable = true;
		wall2.immovable = true;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(SUS, ground);
		FlxG.collide(SUS, ground2);
		FlxG.collide(SUS, wall);
		FlxG.collide(SUS, wall2);

		if (BFandGF)
		{
			remove(SUS);
			add(BF);
			add(GF);
			add(SUS);
		}
		if (BFandGFoff)
		{
			remove(BF);
			remove(GF);
		}

		if (Sussy)
		{
			remove(SUS);
			remove(bg);
			add(blackScreen);
			add(DEAD);
		}
		if (SUSSYoff)
		{
			remove(blackScreen);
			remove(DEAD);
			add(bg);
			add(SUS);
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.sound.play(Paths.sound('boom'));
		}

		if (FlxG.keys.justPressed.D)
		{
			FlxG.sound.play(Paths.sound('walk'));
		}

		if (FlxG.keys.justPressed.A)
		{
			FlxG.sound.play(Paths.sound('walk'));
		}

		if (FlxG.keys.justPressed.W)
		{
			MARIO = new FlxSprite(0, 0).loadGraphic(Paths.image('MARIO'));
			add(MARIO);
			FlxG.sound.play(Paths.sound('BOO'));
		}
		if (FlxG.keys.justReleased.W)
		{
			remove(MARIO);
		}

		if (FlxG.keys.justPressed.S)
		{
			PUSSY = new FlxSprite(0, 0).loadGraphic(Paths.image('PUS'));
			add(PUSSY);
			FlxG.sound.play(Paths.sound('CLAP'));
		}
		if (FlxG.keys.justReleased.S)
		{
			remove(PUSSY);
		}

		if (FlxG.keys.justPressed.E)
		{
			if (BFandGF)
			{
				BFandGFoff = true;
				BFandGF = false;
				trace('oh no, bf and gf!');
				FlxG.sound.play(Paths.sound('exit'));
				FlxG.sound.music.stop();
				FlxG.sound.playMusic('assets/music/BK.mp3');
				#if windows
				FlxG.sound.playMusic('assets/music/BK.ogg');
				#end
			}
			else
			{
				BFandGF = true;
				BFandGFoff = false;
				trace('WOAH BF ANF GF!');
				FlxG.sound.play(Paths.sound('enter'));
				FlxG.sound.playMusic('assets/music/Spookeez_Inst.mp3');
				#if windows
				FlxG.sound.playMusic('assets/music/Spookeez_Inst.ogg');
				#end
			}
		}

		if (FlxG.keys.justReleased.Q)
		{
			if (Sussy)
			{
				SUSSYoff = true;
				Sussy = false;
				trace('oh no, SUS!');
				FlxG.sound.music.stop();
				FlxG.sound.playMusic('assets/music/BK.mp3');
				#if windows
				FlxG.sound.playMusic('assets/music/BK.ogg');
				#end
			}
			else
			{
				Sussy = true;
				SUSSYoff = false;
				trace('WOAH SUS!');
				FlxG.sound.play(Paths.sound('fnf_loss_sfx'));
				FlxG.sound.playMusic('assets/music/sus.mp3');
				#if windows
				FlxG.sound.playMusic('assets/music/sus.ogg');
				#end
			}
		}

		// trace(SUS.x);
	}
}
