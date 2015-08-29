<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/jscript/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jscript/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/stylesheets/jquery-ui.css">

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script language="javascript" type="text/javascript">
	var contextpath="<%=request.getContextPath()%>";
    var map;
    var terrainmap;
    var hybridmap;
    var geocoder;
    var infostring="Verizon Despatch";
    
    var ajaxprocessingdialog;
    
    function showProgressBar()
    
    {
    	var msg="<span id='dialogMsg' style='font-size:11px;'>Processing</span><img src='"+contextpath+"/images/loading.gif' alt='loading'/>";
    	ajaxprocessingdialog=$('<div id="loadingdialog"> style="text-align:center;font-size:11px"></div>').html(msg).dialog({
    		title: "Geo Locate",
    		resizable: false,
    		height: 'auto',
    		width: "300",
    		zIndex: "9999999999999",
    		modal: true,
    		autoOpen: false,
    		draggable: false,
    		buttons:{
    			
    		}
    	});
    	ajaxprocessingdialog.dialog('open');  
    }
    
    
    function hideProgressbar()
    
    {
    	ajaxprocessingdialog.dialog('close');  
    	
    }
    
    function InitializeConstructionMap() {

        var latlng = new google.maps.LatLng(-34.397, 150.644);
        var myOptions =
        {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true
        };
        
        var terrainmapprop =
        {
            zoom: 18,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.TERRAIN,
            disableDefaultUI: true
        };
        
        var hybridmapprop =
        {
            zoom: 18,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.SATELLITE,
            disableDefaultUI: true
        };
        
        map = new google.maps.Map(document.getElementById("map"), myOptions);
        terrainmap = new google.maps.Map(document.getElementById("terrainmap"), terrainmapprop);
        hybridmap = new google.maps.Map(document.getElementById("hybridmap"), hybridmapprop);
  
    }
    
    function InitializeMap() {

        var latlng = new google.maps.LatLng(-34.397, 150.644);
        var myOptions =
        {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true
        };
              
        map = new google.maps.Map(document.getElementById("map"), myOptions);  
    }
    
    function showlatlongonmap(lat,longi)
    {
    	InitializeConstructionMap();
    	var latlng = new google.maps.LatLng(lat,longi);
    	var latlng2 = new google.maps.LatLng(lat,longi);
    	var latlng3 = new google.maps.LatLng(lat,longi);
    	
    	var marker3=new google.maps.Marker({
        	position: latlng,
        	map: map
        	   });
		var marker1=new google.maps.Marker({
        	position: latlng2,
        	map: terrainmap
 	   });
		var marker2=new google.maps.Marker({
        	position: latlng3,
        	map: hybridmap
 	   }); 
		map.setCenter(latlng);
		terrainmap.setCenter(latlng2);
		hybridmap.setCenter(latlng3);
		var myCircle = new google.maps.Circle({
 	   center:latlng,
 	   radius:500,
 	   strokeColor:"#0000FF",
 	   strokeOpacity:0.8,
 	   strokeWeight:2,
 	   fillColor:"#000000",
 	   fillOpacity:0.4
 	 	});
		 myCircle.setMap(map);	
 
 var infowindow = new google.maps.InfoWindow({
 	   content:$('#workorder').val()
 	   });

 	 infowindow.open(map,marker3);
 	 

    	
    }
    
    function FindIpid(){
    	
    	var ipid=$('#workorder').val();	
    	
    	showProgressBar();
    	$.ajax({
    	url: 'GeoLocateAction.jsp',
    	type: 'GET',
    	data: {ajaxipid: ipid,ajaxReq: "getLatLong"},
    	dataType: 'html',
    	error: function(){
    		hideProgressbar();
    		alert('Geometry/Location not available for element');
    		
    	}  
    	}).done(function(resphtml)
    			{
    				var results=resphtml.split(",");
    				hideProgressbar();
    				if(results.length-1==1&&results[0]=="NOTAVAIL")
    					{
    					alert('Geometry/Location not available for element');
    					}
    				else{
    					var ipidlat=results[0];
    					var ipidlong=results[1];
    					
    					$('#hybridmap').show();
    					$('#terrainmap').show();
    					$('#map').show();
    					showlatlongonmap(ipidlat, ipidlong);
    				}
    			});
    	
    	
    	
    	
    	
    }

    function FindLocation() {
        geocoder = new google.maps.Geocoder();
        InitializeMap();

        var address = $('#workorder').val();
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                /*terrainmap.setCenter(results[0].geometry.location);
                hybridmap.setCenter(results[0].geometry.location);*/
                var marker=new google.maps.Marker({
                	position: results[0].geometry.location
                	   });
			/*	var marker1=new google.maps.Marker({
                	position: results[0].geometry.location
         	   });
				var marker2=new google.maps.Marker({
                	position: results[0].geometry.location
         	   }); */
				 new google.maps.InfoWindow({
              	   content:'#445647'
              	   }).open(map,new google.maps.Marker({position: {lat: 13.003196, lng: 80.200601}, map: map}));
				 new google.maps.InfoWindow({
	              	   content:'#221345'
	              	   }).open(map,new google.maps.Marker({position: {lat: 13.006102, lng: 80.203112}, map: map}));
				 new google.maps.InfoWindow({
	              	   content:'#113876'
	              	   }).open(map,new google.maps.Marker({position: {lat: 13.007440, lng: 80.201234}, map: map}));
				 new google.maps.InfoWindow({
	              	   content:'Survey'
	              	   }).open(map,new google.maps.Marker({position: {lat: 13.013196, lng: 80.203601}, map: map}));
				/*new google.maps.Marker({position: {lat: -34, lng: 151}, map: map});
				new google.maps.Marker({position: {lat: -34, lng: 151}, map: map});*/
				marker.setMap(map);
               /* marker1.setMap(terrainmap);
                marker2.setMap(hybridmap);*/
                /*var myCircle = new google.maps.Circle({
                	   center:results[0].geometry.location,
                	   radius:200,
                	   strokeColor:"#0000FF",
                	   strokeOpacity:0.8,
                	   strokeWeight:2,
                	   fillColor:"#000000",
                	   fillOpacity:0.4
                	 });
                myCircle.setMap(map);*/
                /*
                var infowindow = new google.maps.InfoWindow({
                	   content:infostring
                	   });

                	 infowindow.open(map,marker);*/
                	 
                	 google.maps.event.addListener(map,'center_changed',function() {
                		   window.setTimeout(function() {
                		     map.panTo(marker.getPosition());
                		   },5000);
                		 });
                	 
                	/* google.maps.event.addListener(map, 'click', function(event) {
                		   placeMarker(event.latLng);
                		   });

                		function placeMarker(location) {
                		   var marker = new google.maps.Marker({
                		     position: location,
                		     map: map,
                		   });
                		   var infowindow = new google.maps.InfoWindow({
                		     content: 'Latitude: ' + location.lat() +
                		     '<br>Longitude: ' + location.lng()
                		   });
                		   infowindow.open(map,marker);
                		 }*/

            }
            else {
                alert("Geocode was not successful for the following reason: " + status);
            }
        });

    }
    
    $(document).ready(function(){
	$('#locate').button();
	
	$('#locate').click(function(){
		var choice=$('input[type="radio"]:checked').val();
		if(choice=="IPID")
			{
			FindIpid();
			
			}
		else{
			$('#hybridmap').hide();
			$('#terrainmap').hide();
			FindLocation();
			$('#map').show();
		
		}
		
	});
	
	$('.hideable').hide();
	
	
	
	
	
	
	
	
	
    });

</script>

<style>
div#map { border: 1px solid green; }
div#terrainmap { border: 1px solid green; }
</style>
</head>
<body>
<img src="<%=request.getContextPath()%>/images/vzlogo_badge.png" alt="Lone Ninja!" style="float:left;"/>
<center><br>
<h2>The Lone Ninja : Geo Locate</h2>


<table cellpadding="10">
<tr><td><input type="radio" value="IPID" name="choice" id="ipidchoose"><label for="ipidchoose">Element Locate</label></td>
<td><input type="radio" value="AREA" name="choice" id="areachoose"><label for="areachoose">Activity Track</label></td></tr>
<tr>
<td>
    <input id="workorder" type="text" maxlength="12" size="13" />   
</td>
<td>
    <input id="locate" type="button" value="Locate" /></td>
</tr>
</table><hr>
</center>
<div id ="map" class="hideable" style="height: 400px;width: 100%;margin-top: 10px;margin-bottom: 10px;" >
Feature Map:
</div>
<div id ="hybridmap" class="hideable" style="height: 400px;width: 49%;float: left;" >
Hybrid Map:
</div>
<div id ="terrainmap" class="hideable" style="height: 400px;width: 49%;float: right;" >
Terrain Map:
</div>

</body>
</html>