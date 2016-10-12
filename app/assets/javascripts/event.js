$(function () {
  $.get("/welcome.json", function(data) {
    data.map(function(event) {
      var ev = new Event(event.id, event.name, event.date, event.playlist.spotify_url, event.playlist.rsvp_url, event.guest_count, event.event_url)
      var markup = ev.createDiv()
      $("#events-list").append(markup)
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
  <li>
    <p class="event-date">${this.date}</p>
    <div class="row event">
        <div class="divider"></div>
        <div class="col-xs-12 verticalLine">
          <h3 class='event-name'><a href="/events/${this.id}">${this.name}</a></h3>
          <a href="${this.event_url}"> Edit </a>
          <p>Guest Count:${this.guest_count} </p>
          <a href="${this.spotify_url}" target="_blank">Spotify Playlist Link</a>
        </div>
        <div class="col-xs-12">
          <h3>Link to RSVP (click to copy)</h3>
          <p> ${this.rsvp_url} </p>
        </div>
    </div>
  </li>
      `
    return markup
  }
}
