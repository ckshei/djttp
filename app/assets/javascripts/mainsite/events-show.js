App.eventsShow = {
  run: function() {
    $.get("/events/" + $(".js-event").data("id") + ".json", function(data) {
        var ev = new Event(data.id, data.name, data.date, data.playlist.spotify_url, data.playlist.rsvp_url, data.guest_count, data.event_url)
        var markup = ev.createDiv()
        $(".js-event").append(markup)
    $.get("/events/" + $(".js-event").data('id') + "/playlist.json", function(data) {
    data.playlist_songs.map(function(song_data) {
      var markup = 
      `<tr>
        <td>${song_data.song_name}</td>
        <td>${song_data.request_count}</td>
      <tr>`
      $(".js-playlist-data").prepend(markup)
    });
    });
    });

  class Event {
    constructor(id, name, date, spotify_url, rsvp_url, guest_count, event_url) {
      this.id = id
      this.name = name
      this.date = date
      this.spotify_url = spotify_url
      this.rsvp_url = rsvp_url
      this.guest_count = guest_count
      this.event_url = event_url
    }

    createDiv() {
      var markup = `
      <p class="event-date">${this.date}</p>
      <div class="row event">
          <div class="divider"></div>
          <div class="col-xs-12 verticalline">
            <h3 class='event-name'><a href="/events/${this.id}">${this.name}</a></h3>
            <p>guest count: ${this.guest_count} </p>
            <a href="${this.spotify_url}" target="_blank">spotify playlist link</a>
          </div>
          <div class="col-xs-12">
            <h3>Link to RSVP (click to copy)</h3>
            <p> ${this.rsvp_url} </p>
          </div>
      </div>
        `
      return markup
    }
  }
}
}
