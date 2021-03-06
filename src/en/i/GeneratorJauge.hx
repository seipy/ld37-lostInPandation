package en.i;


class GeneratorJauge extends en.Interactive {
	var gen : en.i.Generator;
	public function new(x,y, g) {
		super(x,y);

		gen = g;
		spr.set(Assets.tiles, "jauge");
		spr.setCenterRatio(0.5,0.5);
	}

	override public function postUpdate() {
		super.postUpdate();

		spr.setPosition(344,155);

		if( gen.hasCharge() ) {
			spr.scaleX = 1+M.fabs( Math.cos(game.ftime*0.4)*0.06 );
			spr.scaleY = 1.1/spr.scaleX;
			spr.y-=rnd(0,1);
			//spr.y--;
		}
		else
			spr.setScale(1);

		spr.setFrame( gen.charge );
	}
}
