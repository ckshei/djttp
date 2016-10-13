var App = App || {};
 App.init = function () {

   if($(".events-index").length) {
     App.eventsIndex.run()
   };

   if($(".events-show").length) {
     App.eventsShow.run() 
   };
 };

$(document).on('turbolinks:load', function () {
  App.init();
});
