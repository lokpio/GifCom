$(document).ready(function() {
  window.onload = chatListener();
  loginListener();
  registerListener();
  findListener();
  leaveListener();
  createLinkListener();
  createListener();
  joinListener();
});



function chatListener() {
    var channelName = $('.chat-form').children("input[name=channel]").val();
    runTwilio(channelName);
}

function runTwilio(channelName) {
  console.log('running')
  var username;
  var $chatWindow = $('#messages');

  $.getJSON('/token', {
    identity: username,
    device: 'browser'
  }, function(data) {

        // Alert the user they have been assigned a random username
        username = data.identity;

        // Initialize the IP messaging client
        accessManager = new Twilio.AccessManager(data.token);
        messagingClient = new Twilio.IPMessaging.Client(accessManager);

        // Get the general chat channel, which is where all the messages are
        // sent in this simple application
        var promise = messagingClient.getChannelByUniqueName(channelName);
        promise.then(function(channel) {
          generalChannel = channel;

          if (!generalChannel) {
                // If it doesn't exist, let's create it
                messagingClient.createChannel({
                  uniqueName: channelName,
                  friendlyName: channelName
                }).then(function(channel) {
                  console.log('Created general channel:');
                  console.log(channel);
                  generalChannel = channel;
                  setupChannel();
                });
              } else {
                console.log('Found general channel:');
                console.log(generalChannel);
                setupChannel();
              }
            });
      });

    // Set up channel after it has been found
    function setupChannel() {
        // Join the general channel
        generalChannel.join().then(function(channel) {
        });

        // Listen for new messages sent to the channel
        generalChannel.on('messageAdded', function(message) {
          printMessage(message.author, message.body);
        });
      };

      var $input = $('#chat-input');
      $input.on('keydown', function(e) {
        if (e.keyCode == 13) {
          var data = $input.val();
          var request = $.ajax({
            url:"/chats/message",
            method:"post",
            data: {message :data}
          });

          request.done(function(response ){
            generalChannel.sendMessage(response.message);
            $input.val('');
          });
        };
      });

      function printMessage(fromUser, message) {
        console.log(fromUser)
        console.log(message)
        var $user = $('<span class="username">').text(fromUser + ':');
        if (fromUser === username) {
          $user.addClass('me');
        };
        if (message.includes("http://")||message.includes("https://")){
          var $message = $('<img class="message" src="'+message+'">');
        }else{
          var $message = $('<span class="message">').text(message);
        };
        // var $message = $('<img class="message" src="'+message+'">');
        console.log($message);
        var $container = $('<div class="message-container">');
        $container.append($user).append($message);
        $chatWindow.append($container);
        // $chatWindow.scrollTop($chatWindow[0].scrollHeight);
      };
    };

    function loginListener(){
      $(".page-head").on("click","#login",function(event){
        event.preventDefault();
        var url = $(this).attr("href");
        var method = $(this).attr("method");

        var request = $.ajax({
          url: url,
          method:method
        });

        request.done(function(response){
          $("#login").hide();
          $("#register").show();
          $(".head-div").empty().append(response);
        });
      });
    };

    function registerListener(){
      $(".page-head").on("click","#register",function(event){
        event.preventDefault();
        var login = $("#login");
        var url = $(this).attr("href");
        var method = $(method).attr("method");

        var request = $.ajax({
          method: method,
          url: url
        });

        request.done(function(response){
          $("#register").hide();
          $("#login").show();
          $(".head-div").empty().append(response);
        });
      });
    };

    function findListener(){
      $(".find-channel").on("submit","#find-form",function(event){
        event.preventDefault();
        var url = $(this).attr("action");
        var method = $(this).attr("method");
        var data = $(this).serialize();

        var request = $.ajax({
          url: url,
          method: method,
          data: data
        });

        request.done(function(response){
          $("#find-form").trigger("reset");
          $(".found-channel").empty().append(response);
        });
      });
    };

    function leaveListener(){
      $(".channel-list").on("submit","#leave-form",function(event){
        event.preventDefault();
        var url = $(this).attr("action");
        var method = $(this).children("input[type=hidden]").attr("value");

        var request = $.ajax({
          url: url,
          method: method
        });

        request.done(function(response){
          $("#channel-list-"+response.id).remove();
        });
      });
    };

    function createLinkListener(){
      $(".create-channel").on("click","#create",function(event){
        event.preventDefault();
        var url = $(this).attr("href");
        var method = $(this).attr("method");

        var request = $.ajax({
          url: url,
          method: method
        });

        request.done(function(response){
          $(".create-channel").empty().append(response)
        });
      });
    };

    function createListener(){
      $(".create-channel").on("submit","#create-channel-form",function(event){
        event.preventDefault();
        var url = $(this).attr("action");
        var method = $(this).attr("method");
        var data = $(this).children("input[name=name]").val();

        var request = $.ajax({
          url: url,
          method: method,
          data: {name:data}
        });

        request.done(function(response){
          if (response.error){
            $("#create-channel-form").trigger("reset");
            $("#create-channel-error").empty().append(response.page);
          }else{
            $("#create-channel-error").empty()
            $("#create-channel-form").trigger("reset");
            $(".channel-list-container").append(response);
          };
        });
      });
    };
function joinListener(){
  $(".found-channel").on("submit","#join-channel-form",function(event){
    event.preventDefault();
    var url = $(this).attr("action");
    var method = $(this).attr("method");

    var request = $.ajax({
      url: url,
      method: method
    });

    request.done(function(response){
      $(".join-channel-error").empty().append(response)
    });
  });
};

