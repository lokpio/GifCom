$(document).ready(function() {
  chatButtonListner();
   var pusher = new Pusher('YOUR_APP_KEY');
  var chatWidget = new PusherChatWidget(pusher, {
    chatEndPoint: 'pusher-realtime-chat-widget/src/ruby-sinatra/chat.rb'
});

function chatButtonListner(){
  $(".channel_form").on("submit",function(event){
    event.preventDefault()
    console.log(this)
channel.bind('my-event', function(data) {
  alert('An event was triggered with message: ' + data.message);
});

    var request = $.ajax({
      method:"post",
      url:"/chats/get_info",
      data:$(this).serialize()
    });

    request.done(function(response){
    console.log(response);
    var user = new Pusher(response.app_key);
    var user_channel = user.subscribe(response.channel);

    });

  });
};
