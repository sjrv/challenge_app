$(document).ready(function() {
	function ajaxData(action, element) {
		return {
			act: action,
			question_id: element.parents('.question').data('id'),
			answer_id: element.parents('.answer').data('id')
		};
	}

	function ajaxReq(action, element, complete) {
		return $.ajax('/answers', {
			data: ajaxData(action, element),
			dataType: 'json',
			type: 'POST',
			complete: complete
		});
	};

	$('a.like').bind('ajax:success', function(status, data, xhr) {
  		var answer;
		var count;
		var text;
		//console.log("DONE");
		//console.log(data);
		//console.log(status);
		//res = $.parseJSON(res.responseText);
		//console.log(res);
		answer = $('div.answer[data-id='+data.answer_id+']');
		count = answer.find('span.likes_count');
		text = answer.find('a.like');
		count.html(data.count);
		text.text(data.click);
	});
/*
	$('a.like').click(function() {
		ajaxReq('like', $(this), function(res) {
				var answer;
				var count;
				var text;
				res = $.parseJSON(res.responseText);
				//console.log(res);
				answer = $('div.answer[data-id='+res.answer_id+']');
				count = answer.find('span.likes_count');
				text = answer.find('a.like');
				count.html(res.count);
				text.html(res.click);
		});
	});
*/
})