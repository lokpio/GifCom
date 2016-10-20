$(document).ready(function() {



  openChannel();
  // runTwilio();
});

function openChannel() {
  $('.start-button').on("click",function(event){
    event.preventDefault();
    var channelName = $(this).children("input[name=channel]").val();
    console.log(channelName)
    runTwilio(channelName);
  })
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

        console.log(channelName)
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
    }

        var $input = $('#chat-input');
    $input.on('keydown', function(e) {
        if (e.keyCode == 13) {
            generalChannel.sendMessage($input.val())
            $input.val('');
        }
    });

        function printMessage(fromUser, message) {
          console.log(fromUser)
          console.log(message)
        var $user = $('<span class="username">').text(fromUser + ':');
        if (fromUser === username) {
            $user.addClass('me');
        }
        var $message = $('<span class="message">').text(message);
        var $container = $('<div class="message-container">');
        $container.append($user).append($message);
        $chatWindow.append($container);
        // $chatWindow.scrollTop($chatWindow[0].scrollHeight);
    }
}

