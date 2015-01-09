/*
 * to do
$(document).on('ready page:load', function() {
	console.log('loaded');

	$('input#user_avatar').change(function() {
		console.log('update');
		var file = $(this);

		console.log('file');
		console.log(file[0]);
		file = file[0].files;

		console.log(file);

		if (!file || !file.length)
			return;		

		var reader = new FileReader();

		reader.addEventListener('load', function(event) {
			var picFile = event.target;
			var div = $('<div>', {
				class: 'preview',
				src: picFile.result
			});
		});

		reader.readAsBinaryString(file);

		console.log(reader);
		console.log(file);



	});
});
*/