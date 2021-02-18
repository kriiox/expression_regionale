 
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
