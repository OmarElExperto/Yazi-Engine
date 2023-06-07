import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["Bop",							"Vence la Cancion \"Boopebo\"",						'boopebo',				 false],
		["Fresco",						"Vence la Cancion \"Fresh\" ",						'fresh',				 false],
		["Papa dearest",				"Vence la Cancion \"Dad Battle\" .",				'dad',					 false],
		["Spooky",						"Vence la Cancion \"Spookez\" .",					'spook',				 false],
		["Sur",							"Vence la Cancion \"South\" .",						'south',				 false],
		["Mountstro",					"Vence la Cancion \"Monster\" .",					'monster',				 false],
		["Pico",						"Vence la Cancion \"Pico\" .",						'pico	',				 false],
		["Nice",						"Vence la Cancion \"Philly Nice\" .",				'philly',				 false],
		["Blammed",						"Vence la Cancion \"Blamed\" .",					'blammed',				 false],
		["Panties",						"Vence la Cancion \"Satin Panties\" .",				'Panties',				 false],
		["Secundaria",					"Vence la Cancion \"High\" .",						'Secundaria',			 false],
		["M.I.L.F",						"Vence la Cancion \"MILF\" .",						'milf',					 false],
		["Cocoa",						"Vence la Cancion \"Cocoa\" .",						'Cocoa',				 false],
		["Rompope",						"Vence la Cancion \"Eggnong\" .",					'Rompope',				 false],
		["Horror",						"Vence la Cancion \"Winter Horroland\" .",			'Horror',				 false],
		["Dulce",						"Vence la Cancion \"Senpai\" .",					'Dulce',				 false],
		["Rosado",						"Vence la Cancion \"Roses\" .",						'rosado',				 false],
		["Espiritu",					"Vence la Cancion \"Thorns\" .",					'Espiritu',				 false],
		["Asco",						"Vence la Cancion \"Ugh\" .",						'asco',					 false],
		["Armas",						"Vence la Cancion \"Guns\" .",						'Armas',				 false],
		["Estres",						"Vence la Cancion \"Stress\" .",					'estres',				 false],
		["Loco de Friday Night",		"Juega a Friday... Viernes.",						'friday_night_play',	 true],
		["Me Llamaban Daddy Tambien",	"Vence la Week 1 Sin Misses.",						'week1_nomiss',			false],
		["No mas Trucos",				"Vence la Week 2 Sin Misses.",						'week2_nomiss',			false],
		["Me decian  Hitman",			"Vence la Week 3 Sin Misses.",						'week3_nomiss',			false],
		["Matador de Lady",				"Vence la Week 4 Sin Misses.",						'week4_nomiss',			false],
		["Navidad Perdida",				"Vence la Week 5 Sin Misses.",						'week5_nomiss',			false],
		["Alto Puntaje!!",				"Vence la Week 6 Sin Misses.",						'week6_nomiss',			false],
		["Buenardo!",					"Vence la Week 7 Sin Misses.",						'week7_nomiss',			false],
		["Un desastre en el Funk!",		"Completa una Cancion con un Rango Menor a  20%.",	'ur_bad',				false],
		["Sos Re Pro",					"Completa una Cancion Con un Rango de 100%.",		'ur_good',				false],
		["Entusiasta del Asesinato",	"Ve Al Henchmen Morir 100 veces.",					'roadkill_enthusiast',	false],
		["Sobrecantando Mucho...?",		"Manten Presionada una nota por 10 Segundos.",		'oversinging',			false],
		["Hiperactivo",					"Finaliza una Cancion Sin Parar Ningun Momento.",	'hype',					false],
		["Solo 2 de Nosotros",			"Finaliza una Cancion con Presionar 2 teclas.",		'two_keys',				false],
		["Jugador de Tostadora",		"Has Tratado de Jugar este Mod en una Tostadora?",	'toastie',				false],
		["Desarrollador",				"Vence la Cancion \"Test\" Con el Chart Editor.",	'debugger',				 false],


	];
	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();

	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name) && achievementsMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			loadGraphic(Paths.image('achievements/' + tag));
		} else {
			loadGraphic(Paths.image('achievements/lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievements/' + name));
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("Krabby Patty.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("Krabby Patty.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}