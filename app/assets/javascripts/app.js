// Add proper content-type to all AJAX requests by default
$.ajaxSetup({
  beforeSend: function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript'); }
});

$(document).ready(function() {
  handleRequiresFanActions();

  $('[data-toggle-popup]').click(function(){
    switch ($(this).data('toggle-popup')) {
        case "userDenied":
          toggleUserDeniedPopup();
          break;
    }
  })
});

$(document).on('intraseec:fb:loaded', function() {
  handlePermissionsLink();
});

function handlePermissionsLink() {
  $('.permissions').click(
    function(event){
      event.preventDefault();
      FB.login(function(response) {
        if (response.authResponse) {
          window.location = "/tab?signed_request=" + response.authResponse.signedRequest;
        } else {
          toggleUserDeniedPopup();
        }
      }, {scope: 'user_likes'});
    }
  );
}

function handleRequiresFanActions() {
  $(".requires_fan").click(
    function(event){
      event.preventDefault();
      FB.getLoginStatus(function(response) {
        if (response.status === 'connected') {
          var accessToken = response.authResponse.accessToken;
          FB.api("/me/likes?access_token=" + accessToken, function(result) {
            var array = $.map(result.data, function(o) { return o["id"]; });
            if ($.inArray(AppSettings.pageId, array) == -1) {
              showRequireFanPopup();
              FB.Event.subscribe('edge.create',
                function(response) {
                  closeRequireFanPopup();
                  $('form').submit();
                }
              );
            } else {
              $('form').submit();
            }
          });
        } else if (response.status === 'not_authorized') {
          toggleUserDeniedPopup();
        }
      });
    }
  );
}

function toggleUserDeniedPopup(){
  $('#user-denied-popup').toggle();
  $('#user-denied-popup-background').toggle();
}