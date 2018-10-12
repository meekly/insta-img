$('#add-image-btn').click(function() {
    var formData = new FormData(this.files[0]);
    var user = $('#user').attr('name');
    $.ajax({
        url: '/user/'+user,
        type: 'POST',
        data: formData,
        //Options to tell JQuery not to process data or worry about content-type
        cache: false,
        contentType: false,
        processData: false
    });
});
