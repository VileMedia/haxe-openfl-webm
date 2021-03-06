package webm;

import cpp.Lib;
import haxe.io.Bytes;
import haxe.io.BytesData;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;

class VpxDecoder
{	
	public static var version(get, null):String;
	static function get_version():String
	{
		return hx_vpx_codec_iface_name();
	}
	
	private var context:Dynamic;
	
	public function new() 
	{
		context = hx_vpx_codec_dec_init();
	}
	
	public function decode(data:BytesData)
	{
		hx_vpx_codec_decode(context, data);
	}
	
	public function getAndRenderFrame(bitmapData:BitmapData)
	{
		var info = hx_vpx_codec_get_frame(context);
		
		if (info != null) 
		{
			var byteArray:ByteArray = ByteArray.fromBytes(Bytes.ofData(info[2]));
			bitmapData.lock();
			bitmapData.setPixels(bitmapData.rect, byteArray);
			bitmapData.unlock();
		}
	}
	
	static var hx_vpx_codec_iface_name:Void -> String = Lib.load("webm", "hx_vpx_codec_iface_name", 0);
	static var hx_vpx_codec_dec_init:Void -> Dynamic = Lib.load("webm", "hx_vpx_codec_dec_init", 0);
	static var hx_vpx_codec_decode:Dynamic -> BytesData -> Array<Int> = Lib.load("webm", "hx_vpx_codec_decode", 2);
	static var hx_vpx_codec_get_frame:Dynamic -> Array<Dynamic> = Lib.load("webm", "hx_vpx_codec_get_frame", 1);
}