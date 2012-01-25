(function($, undefined) {
  // jQuery extensions
  $.isInArray     = function(value, array) { return -1 != $.inArray(value, array); }
  $.isDefined     = function(value) { return value !== undefined; }
  $.isNotDefined  = function(value) { return value === undefined; }

  window.Merch = {
    init: function() {
      $(".alert").alert();
    },
    // Used on nested forms to remove an item and mark it for deletion.
    // This requires the nested item have a hidden _destroy field directly
    // following the anchor.
    deleteNestedItem: function(clicked, selector) {
      var $clicked = $(clicked);
      $clicked.next("input[type=hidden]:first").val("1");
      $clicked.closest(selector).slideUp("fast");
    }
  }
  
  $(function() {
    Merch.init();
  });
})(jQuery);

(function() {
    window.PinIt = window.PinIt || { loaded:false };
    if (window.PinIt.loaded) return;
    window.PinIt.loaded = true;
    function async_load(){
        var s = document.createElement("script");
        s.type = "text/javascript";
        s.async = true;
        s.src = "http://assets.pinterest.com/js/pinit.js";
        var x = document.getElementsByTagName("script")[0];
        x.parentNode.insertBefore(s, x);
    }
    if (window.attachEvent)
        window.attachEvent("onload", async_load);
    else
        window.addEventListener("load", async_load, false);
})();
