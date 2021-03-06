class Tutorial extends dn.Process {
	public static var ME : Tutorial;
	var game : Game;
	var step : Int;
	var colorAdd : h3d.Vector;

	public function new() {
		super(Game.ME);
		ME = this;
		step = 0;
		game = Game.ME;
		colorAdd = new h3d.Vector();
	}

	public inline function started() return step>0;

	public function nextIfAt(s) {
		if( step==s ) {
			next();
			return true;
		}
		else
			return false;
	}
	public function next() {
		step++;
		switch( step ) {
			case 1 : display( Lang.t._("Plant some bamboo in a pot") );
			case 2 : display( Lang.t._("Warm up your fire (use WOOD or BAMBOO)") );
			case 3 : display( Lang.t._("Wait for a bamboo to grow") );
			case 4 : display( Lang.t._("Find and plant a fruit") );
			case 5 : display( Lang.t._("Unlock a third pot") );
			default : hide();
		}
	}


	var curMsg : h2d.Object;
	function hide() {
		if( curMsg!=null ) {
			var s = curMsg;
			tw.createS(s.y, s.y-30, 1);
			tw.createS(s.alpha, 0, 1).end( s.remove );
			curMsg = null;
		}
	}
	function display(m:LocaleString) {
		hide();
		var c = 0x2E2D48;
		var wr = new h2d.Object();
		curMsg = wr;
		var bg = new h2d.Graphics(wr);

		var px = 5;
		var py = 2;
		var tf = new h2d.Text(Assets.font, wr);
		tf.text = Lang.t._("SURVIVAL TIP:")+" "+m;
		tf.setPosition(px,py);
		tf.textColor = 0xFFA600;
		//tf.maxWidth = 440-260;
		tf.colorAdd = colorAdd;

		var w = tf.textWidth+px*2;
		var h = tf.textHeight+py*2;
		bg.beginFill(dn.Color.brightnessInt(c,-0.5));
		bg.drawRect(-1,-1,w+2,1);
		bg.drawRect(-1,h,w+2,1);
		bg.drawRect(-1,-1,1,h+2);
		bg.drawRect(w,-1,1,h+2);
		bg.beginFill(c);
		bg.drawRect(0,0,w,h);
		bg.colorAdd = colorAdd;

		bg.beginFill(0xffffff,0.08);
		bg.drawRect(0,0,w,1);

		wr.setPosition(Std.int(330-w*0.5), 290);

		tw.createS(wr.y, wr.y+10>wr.y, 1);
		tw.createS(wr.alpha, 0>1, 1);

		game.scroller.add(wr, Const.DP_UI);
	}

	override function update() {
		super.update();

		var f = 0.8;
		colorAdd.r*=Math.pow(f,tmod);
		colorAdd.g*=Math.pow(f,tmod);
		colorAdd.b*=Math.pow(f,tmod);

		if( !cd.hasSetS("blink",1) )
			colorAdd.setColor(0xffcc00);
	}
}
