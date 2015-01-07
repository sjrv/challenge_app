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

	$('span.like').click(function() {
		ajaxReq('like', $(this), function(res) {
				var answer;
				var count;
				var text;
				res = $.parseJSON(res.responseText);
				answer = $('div.answer[data-id='+res.answer_id+']');
				count = answer.find('span.likes_count');
				text = answer.find('span.like');
				count.html(res.count);
				text.html(res.click);
		});
	});

	$('span.accept').click(function() {
		ajaxReq('accept', $(this), function(res) {
				var answer;
				var text;
				res = $.parseJSON(res.responseText);
				answer = $('div.answer[data-id='+res.answer_id+']');
				text = answer.find('span.accept');
				text.html(res.click);
				if (res.accepted)
					answer.addClass('accepted');
				else
					answer.removeClass('accepted');
				
			});
	});	
})