var App = App || {};
 App.init = function () {

   if($(".events-index").length) {
     console.log("first part")
     App.eventsIndex.run()
   };

 };

$(document).on('turbolinks:load', function () {
  App.init();
});
