// from http://groups.google.com/group/prototype-scriptaculous/browse_thread/thread/badf3974a0dd5ac6
function bubbledFromChild(element, event)  {
  var target = $(event).element();
  if (target === element) target = event.relatedTarget;
  return (target && target.descendantOf(element));
}

function findPosX(obj) 
{
  var curleft = 0;
  if (obj.offsetParent) 
  {
    while (obj.offsetParent) 
        {
            curleft += obj.offsetLeft
            obj = obj.offsetParent;
        }
    }
    else if (obj.x)
        curleft += obj.x;
    return curleft;
}

function findPosY(obj) 
{
    var curtop = 0;
    if (obj.offsetParent) 
    {
        while (obj.offsetParent) 
        {
            curtop += obj.offsetTop
            obj = obj.offsetParent;
        }
    }
    else if (obj.y)
        curtop += obj.y;
    return curtop;
}

Event.addBehavior({
  ".timelineitem-name:mouseover" : function(e){
    if(!bubbledFromChild(this,e))
		{
      var id = $(this).readAttribute("id").match(/[0-9]+$/)[0];
      var container = $(this).up(".parent-container");

			//divo = document.getElementById("timelineitem-name"+id);
			posx = findPosX(this);
			posy = findPosY(this);
			offx = 50;
			offy = 25;
			
      $$(".timelineitem").each( function(e) {
        e.hide();
      });
      if($(container).down("#timelineitem-"+id))
			{
				
				
				ho = document.getElementById("timelineitem-"+id);
				ho.style.top = posy + offy + "px";
				ho.style.left = posx + offx + "px";
				
        new Effect.Appear("timelineitem-"+id, {queue: 'end', duration: .5})
      }
			else
			{
        if(Ajax.activeRequestCount == 0)
				{
          var url = $(this).down("a").readAttribute("href");
          new Ajax.Request(url,{
            method: 'get',
            onSuccess: function(xhr){
              container.insert({bottom: xhr.responseText});

							ho = document.getElementById("timelineitem-"+id);
							ho.style.top = posy + offy + "px";
							ho.style.left = posx + offx + "px";
							ho.style.display = "none";
							
							new Effect.Appear("timelineitem-"+id, {queue: 'end', duration: .5})
            }});
        }
      }      
    }
  },
  
  ".timelineitem-name:mouseout" : function(e){
    if(!bubbledFromChild(this,e))
		{
			var id = $(this).readAttribute("id").match(/[0-9]+$/)[0];
      $$(".timelineitem").each( function(e) {
        //e.hide();
				new Effect.Fade("timelineitem-"+id, {duration: 0.5});
      });      
    }
  }
})

