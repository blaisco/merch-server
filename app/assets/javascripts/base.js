$(function() {
  $(".alert-message").alert();
  $(".other-items img").twipsy();
});

(function($, undefined) {
  // jQuery extensions
  $.isInArray     = function(value, array) { return -1 != $.inArray(value, array); }
  $.isDefined     = function(value) { return value !== undefined; }
  $.isNotDefined  = function(value) { return value === undefined; }

  window.Merch = {
    // Used on nested forms to remove an item and mark it for deletion.
    // This requires the nested item have a hidden _destroy field directly
    // following the anchor.
    deleteNestedItem: function(clicked, selector) {
      var $clicked = $(clicked);
      $clicked.next("input[type=hidden]:first").val("1");
      $clicked.closest(selector).slideUp("fast");
    }
  }
})(jQuery);
