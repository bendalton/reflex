package reflex.skins
{
	import flash.events.Event;
	
	import flight.binding.Bind;
	import flight.position.IPosition;
	
	import legato.components.ScrollBarGraphic;
	
	import reflex.layout.Align;
	import reflex.layout.Block;
	import reflex.layout.Layout;

	public class ScrollBarSkin extends GraphicSkin
	{
		[Bindable]
		public var position:IPosition;
		
		private var scrollBarGraphic:ScrollBarGraphic;
		
		public function ScrollBarSkin(graphic:ScrollBarGraphic = null)
		{
			graphic = scrollBarGraphic = graphic || new ScrollBarGraphic()
			super(scrollBarGraphic);
			
			var block:Block;
			block = new Block(graphic.background);
			block.scale = true;
			block.dock = Align.FILL;
			block = new Block(graphic.bwdBtn);
			block.scale = true;
			block.dock = Align.LEFT;
			block = new Block(graphic.fwdBtn);
			block.scale = true;
			block.dock = Align.RIGHT;
			block = new Block(graphic.track);
			block.scale = true;
			block.dock = Align.FILL;
			block = new Block(graphic.thumb);
			block.scale = true;
			block.anchor.top = block.anchor.bottom = 0;
			block.bounds.minWidth = block.bounds.minHeight = 10;
			
			Bind.addListener(onSizeChange, this, "position.size");
			Bind.addListener(onSizeChange, this, "position.space");
		}
		
		private function onSizeChange(event:Event):void
		{
			if (position == null) {
				return;
			}
			
			if (position.filled) {
				scrollBarGraphic.thumb.visible = false;
				return;
			}
			
			scrollBarGraphic.thumb.visible = true;
			var block:Block = Layout.getLayout(scrollBarGraphic.thumb) as Block;
			block.width = scrollBarGraphic.track.width/position.size * position.space;
		}
		
	}
}