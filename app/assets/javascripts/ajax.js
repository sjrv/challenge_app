$(document).ready(function() {
  $('a.like').bind('ajax:success', function(status, data, xhr) {
    var answer;
    var count;
    var text;
    answer = $('div.answer[data-id='+data.answer_id+']');
    count = answer.find('span.likes_count');
    text = answer.find('a.like');
    count.html(data.count);
    text.text(data.click);
  });
})