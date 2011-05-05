// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

  function startPolling() {
    setInterval(checkForEvents, 2000);
  }

  function checkForEvents(eventNum) {
    new Ajax.Request('/events/recent/' + eventCount + '.json', {      
       method:'get',
       onSuccess: function(transport){
         var response = transport.responseText;
         if (response) {
           makeDivs(response.evalJSON(), eventCount);  
         }
       },
       onFailure: function(){}
    });
  }

  function makeDivs(response, eventNum) {
    eventCount = response.length + eventNum;
    document.getElementById("total").innerHTML = eventCount;
    for (var i = 0; i < response.length; i++) {
      var event = response[i].event;
      var newdiv = document.createElement('div');
      currentDivs.splice(0, 0, newdiv);
      newdiv.className = "event";
      newdiv.style.left = 50;
      newdiv.style.top = 30;
      newdiv.innerHTML = "<b>Event: " + event.id + "</b>, email: " + event.email + ", ip address: " 
          + event.ip + ", category: " + event.category  
          + ", action: " + event.action + ", label: " + event.label + ", value: " + event.value;
      document.body.appendChild(newdiv); 
      var height = 50;
      for (var i = response.length; i < currentDivs.length; i++) {
        height += currentDivs[i - 1].offsetHeight;
        currentDivs[i].style.top = height + 5*i;
      }
      if (height + newdiv.offsetHeight > window.innerHeight) {
        var oldDiv = currentDivs.pop();
        oldDiv.parentNode.removeChild(oldDiv);
      }
      
      window.setTimeout(function() {
        newdiv.style.left = 5;
        newdiv.style.top = 50;
      }, 1000);
    }
  }

  function stopPolling() {
    clearInterval(intervalID);
  }
