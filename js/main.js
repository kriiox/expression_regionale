 
 function afficherSelectGroupe()
 {
  const labelSelectorGroupe = document.getElementById('labelSelectorGroupe');
  labelSelectorGroupe.style.display = 'block';
  const selectorGroupe = document.getElementById('selectorGroupe');
  selectorGroupe.style.display = 'block';
  afficherExpression();
 }

 
 function afficherExpression()
  {
    const selectorGroupe = document.getElementById('selectorGroupe');
    groupe = selectorGroupe.value;
    const selectorRegion = document.getElementById('selectorRegion');
    region = selectorRegion.value;

  if (groupe=="" && region =="")
    {
    document.getElemeafficherRegionntById("txtHint").innerHTML="";
    return;
    }
  if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
    }
  else
    {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  xmlhttp.onreadystatechange=function()
    {
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
      document.getElementById("result").innerHTML=xmlhttp.responseText;
      }
    }
  xmlhttp.open("GET","expressionImport.php?groupe="+groupe+"&region="+region,true);
  xmlhttp.send();
  }

function importDonnees()
{
   var couleurs = ['#ff0000', '#750000','#757b00','#757bb6','#cd7bb6','#cd0ab6','#0e0afe','#01fe01','#795801','#f9c9ef'];
   var indexTab = 0;

   var spanDonnees = document.getElementById("donnees");
   var donnees = spanDonnees.innerText;
   var donneesJson = JSON.parse(donnees);

   var spanExpressions = document.getElementById("expressions");
   var expressions = spanExpressions.innerText;
   var expressionsJson = JSON.parse(expressions);


   donneesJson.forEach(element => {
       element.forEach(ids => {
           var areas = $("#areas");
           var c = canvas.getContext("2d");
           areas.children().each(function(i){
               var area = $(this);
               if(area.context.id == ids){                    
                   area.data("fillStyle",couleurs[indexTab]);
               }
               var shape = area.attr("shape");
               var coords = area.attr("coords").split(",");
               var fillStyle = area.data("fillStyle");
               var strokeStyle = area.data("strokeStyle");
               var lineWidth = area.data("lineWidth");
                 if (fillStyle){
                   c.fillStyle = fillStyle; 
                 }
                 if (strokeStyle){
                   if (lineWidth){
                     c.lineWidth = lineWidth; 
                   }
                   c.strokeStyle = strokeStyle;   
                 }
                 c.beginPath();
                 var leng = coords.length;
                 c.moveTo(coords[0], coords[1]);
                 for (var i = 2; i < leng; i+=2){
                   c.lineTo(coords[i], coords[i+1]); 
                 }
                 c.closePath();
                 fillStroke(fillStyle, strokeStyle);
               c.lineWidth = 1;
             });
             function fillStroke(fillStyle, strokeStyle){
               if (fillStyle) c.fill();
               if (strokeStyle) c.stroke();
             }
           
           });
           indexTab++;
       });
       indexTab = 0;
       expressionsJson.forEach(element => {
           var li = document.createElement("li");
           li.style.color = couleurs[indexTab];
           li.innerHTML=element;
           legende.appendChild(li);
           indexTab++;

       });
       var li = document.createElement("li");
       li.style.color = "#000000";
       li.innerHTML= "Aucune données";
       legende.appendChild(li);


}
