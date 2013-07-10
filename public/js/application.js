$(document).ready(function() {
  $('.post_tweet_form').on('submit', function(e){
    e.preventDefault();
    $.post('/post_tweet', $(this).serialize()).done( function() {
      var timerId = setInterval(function(){$.get('/status').done( function(response) {
        $('.status').html(response);
        console.log(response)
        if(response === "It worked!"){
          clearInterval(timerId);
        }
      })}, 1000);});
  });
});
