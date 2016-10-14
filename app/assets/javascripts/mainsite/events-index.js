App.eventsIndex = { run: function() {
    $.get("/events.json", function(data) {
      data.map(function(event_data) {
        var ev = new Event(event_data.id, event_data.name, event_data.date, event_data.playlist.spotify_url, event_data.playlist.rsvp_url, event_data.guest_count, event_data.event_url, event_data.playlist.song_count)
        var markup = ev.createDiv()
        $("#js-events-list").append(markup)
      });
    });

  class Event {
    constructor(id, name, date, spotify_url, rsvp_url, guest_count, event_url, song_count) {
      this.id = id
      this.name = name
      this.date = date
      this.spotify_url = spotify_url
      this.rsvp_url = rsvp_url
      this.guest_count = guest_count
      this.event_url = event_url
      this.song_count = song_count
    }

    createDiv() {
      var markup = `
    <li>
      <p class="event-date">${this.date}</p>
      <div class="row event">
          <div class="divider"></div>
          <div class="col-xs-12 event-details">
            <h3 class='event-name'><a href="/events/${this.id}">${this.name}</a></h3>
            <p>Guest Count: ${this.guest_count} </p>
            <p>Song Count: ${this.song_count} </p>
            <a href="${this.spotify_url}" target="_blank">Spotify Playlist Link</a>
          </div>
          <div class="col-xs-12 rsvp">
            <h3>RSVP Link(click to copy)</h3>
            <p> ${this.rsvp_url} </p>
          </div>
      </div>
    </li>
        `
      return markup
    }
  }
   $('form').submit(function(event) {
     event.preventDefault();

     var values = $(this).serialize();
     var posting = $.post('/events', values);
     posting.done(function(event_data) {
       if (event_data.id) {
        var ev = new Event(event_data.id, event_data.name, event_data.date, event_data.playlist.spotify_url, event_data.playlist.rsvp_url, event_data.guest_count, event_data.event_url)
       var markup = ev.createDiv()
         $("#js-events-list").prepend(markup)
         $("#event_name").val('')
         $("#event_date").val('')
       } else {
         debugger
         $("#js-error-messages").html(event_data.date[0])
       }
     });
   });
}
}
