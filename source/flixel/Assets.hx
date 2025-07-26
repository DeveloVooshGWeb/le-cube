package flixel;

import openfl.utils.Assets as OpenFLAssets;
import openfl.utils.AssetType;

using StringTools;

class Assets
{
	public static var soundExt:String = #if web "mp3" #else "ogg" #end;
	
	public static function idPath(id:String, ?assetType:AssetType, ?lib:String)
	{
		var assetList:Array<String> = [];
		if (assetType == null)
			assetList = OpenFLAssets.list();
		else
			assetList = OpenFLAssets.list(assetType);
		var collectedAssets:Array<String> = [];
		if ( (assetType == MUSIC || assetType == SOUND) && !OpenFLAssets.exists(id) )
			id += '.$soundExt';
		for (asset in assetList)
			if ( (lib != null && asset.startsWith(lib + ":") && asset.contains(id) ) || (lib == null && asset.contains(id)) )
				collectedAssets.push(asset);
		// copied from https://ashes999.github.io/learnhaxe/sorting-an-array-of-strings-in-haxe.html
		collectedAssets.sort(
			function(a:String, b:String):Int
			{
				a = a.toUpperCase();
				b = b.toUpperCase();
				
				if (a <  b)
					return -1;
				else if (a > b)
					return 1;
				else
					return 0;
			}
		);
		if (collectedAssets.length > 0)
			return collectedAssets[0];
		else
			return null;
	}
	
	public static function exists(id:String, ?assetType:AssetType, ?lib:String):Bool
	{
		return OpenFLAssets.exists(idPath(id, assetType, lib));
	}
}