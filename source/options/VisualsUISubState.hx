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

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuales y UI';
		rpcTitle = 'Menu De Config de Visuales y UI'; //for Discord Rich Presence

		var option:Option = new Option('Splashes de Nota',
			"Si Esta Desmarcado Al Presionar \"Sick!\" las notas no Mostraran Particulas.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Ocultar HUD',
			'Si se Desmarca, No Mostrara los Elementos del Hud',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Barra de Tiempo:',
			"Que es Lo que La Barra De Tiempo Deberia Mostrar?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Luces Flash',
			"Desmarca Esto Si Eres Sensible a las Luces Flasheantes!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zooms de Camara',
			"Si Esta Desmarcada, La Camara No Hara Zoom Cuando Este En un Beat.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zoom al Presionr una Nota',
			"Si Esta Desmarcado, Oculta El Zoom En el Puntaje\nCada Vez que Presiones una Nota.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Transparencia de la Barra',
			'Como Seria la Transparencia que la Barra Tendria Que Tener.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('Contador de FPS',
			'Si Esta Desmarcado, Oculta El Contador de FPS.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end
		
		var option:Option = new Option('Rola del Menu Pausa:',
			"Que Cancion Prefieres Para El Menu de Pausa",
			'pauseMusic',
			'string',
			'Tea Time',
			['Nada', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Buscar Actualizaciones',
			'En las Nuevas Builds de Salida Saldra un Aviso de Actualizacion,Si Esta Desmarcado No Buscara Actualizaciones.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		var option:Option = new Option('Stakeo de Combos',
			"Si Esta Desmarcado, No Se Estaquearan Los Combos por lo que sera mas Facil Leerlos",
			'comboStacking',
			'bool',
			true);
		addOption(option);

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end
}
