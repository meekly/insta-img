$(document).ready(function(){
    $('#profile-image-upload').click(function() {
	var formData = new FormData();
	var file = document.getElementById('image-holder').files[0];
	formData.append('file', file);
	var user = $('#user').attr('name');
	$.ajax({
            url: '/user/'+user,
            type: 'POST',
            data: formData,
            //Options to tell JQuery not to process data or worry about content-type
            cache: false,
            contentType: false,
            processData: false,
	    success: function(data) { location.reload() },
	    error: function(data) { location.reload() },
	});
    });
});
