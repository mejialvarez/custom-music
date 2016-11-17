$(document).ready(function(){
  var control=0;
  $("#hide").on( "click", function() {
    control++;
    if (control%2==1) {
      $('#songs').hide(); //oculto mediante id
      $('#hide').text("Mostrar playlist");
    }
    else{
      $('#songs').show(); //oculto mediante id
      $('#hide').text("Ocultar playlist");
    }
    //$('.target').hide(); //muestro mediante clase
  });
});