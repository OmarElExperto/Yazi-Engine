package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Ajustes de Jugabilidad';
		rpcTitle = 'Menu de Ajustes de Jugabilidad'; //for Discord Rich Presence

		var option:Option = new Option('Modo Controlador',
			'Marca Esto Si quieres Jugar\nCon Un Controlador en Ves de Tu tecclado.',
			'controllerMode',
			'bool',
			false);
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Downscroll', //Name
			'Si Esta Chequeado Las notas Iran Hacia Abajo.', //Description
			'downScroll', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Scroll Centrado',
			'Si Esta Chequeado, las Notas estaran en Medio.',
			'middleScroll',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Notas del Oponente',
			'Si Esta Desmarcado, Estas se Ocultaran',
			'opponentStrums',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Tipeo Fantasma',
			"Si Esta Desmarcado, No Obtendras Errores\nMientras esas notas no esten Disponibles Para Presionar.",
			'ghostTapping',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Desabilitar el Reset',
			"Si Esta desmarcado, Este No hara Nada Mientras Presionas la Tecla",
			'noReset',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Volumen De las Teclas',
			'Las Notas Chistosas Haran \"Tick!\" Cuando Tu las Presiones."',
			'hitsoundVolume',
			'percent',
			0);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option('Offset de Rating',
			'Cambiar que tan Tarde/Temprano Tendras "Sick!"\nEntre mas grande el Valor mas tarde es.',
			'ratingOffset',
			'int',
			0);
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('Ventana de Presionar Sick!',
			'Cambiar el monto de Tiempo\nCuando Presionas "Sick!" En milisegundos.',
			'sickWindow',
			'int',
			45);
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('Ventana de Presionar Good!',
			'Cambiar el monto de Tiempo\nCuando Presionas "Good!" En milisegundos.',
			'goodWindow',
			'int',
			90);
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('Ventana de Presionar Bad!',
			'Cambiar el monto de Tiempo\nCuando Presionas "Bad!" En milisegundos.',
			'badWindow',
			'int',
			135);
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('Frames Seguros',
			'Cambiar Cuantos Frames Tienes\nMientras Presionas una nota Temprano/Tarde.',
			'safeFrames',
			'float',
			10);
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		super();
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
	}
}