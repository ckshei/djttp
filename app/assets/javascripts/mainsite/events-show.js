App.eventsShow = {
  run: function() {
    $.get("/events/" + $(".js-event").data("id") + ".json", function(data) {
        var ev = new Event(data.id, data.name, data.date, data.playlist.spotify_url, data.playlist.rsvp_url, data.guest_count, data.event_url, data.playlist.song_count)
        var markup = ev.createDiv()
        $(".js-event").append(markup)
    $.get("/events/" + $(".js-event").data('id') + "/playlist.json", function(data) {
    data.playlist_songs.map(function(song_data) {
      var markup = 
      `<tr>
        <td>${song_data.song_name}</td>
        <td>${song_data.request_count}</td>
      <tr>`
      $(".js-playlist-data").append(markup)
    });
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
      <p class="event-date">${this.date}</p>
      <div class="row event">
          <div class="divider"></div>
          <div class="col-xs-12 event-details">
            <h3 class='event-name'>${this.name}</h3>
            <p>Guest Count: ${this.guest_count} </p>
            <p>Song Count: ${this.song_count} </p>
            <a href="${this.spotify_url}" target="_blank">Spotify Playlist Link</a>
          </div>
          <div class="col-xs-12 rsvp">
            <h3>RSVP Link (click to copy)</h3>
            <p> ${this.rsvp_url} </p>
          </div>
      </div>
        `
      return markup
    }
  }
}
}
