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


init();
function init(){
    var current = 0;
    var audio = $('#audio');
    var playlist = $('#playlist');
    var tracks = playlist.find('li a');
    var len = tracks.length - 1;
    audio[0].volume = .10;
    audio[0].play();
    playlist.find('a').click(function(e){
        e.preventDefault();
        link = $(this);
        current = link.parent().index();
        run(link, audio[0]);
    });
    audio[0].addEventListener('ended',function(e){
        current++;
        if(current == len){
            current = 0;
            link = playlist.find('a')[0];
        }else{
            link = playlist.find('a')[current];    
        }
        run($(link),audio[0]);
    });
}
function run(link, player){
        player.src = link.attr('href');
        par = link.parent();
        par.addClass('active').siblings().removeClass('active');
        player.load();
        player.play();
}