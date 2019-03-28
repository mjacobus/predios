export default class BuildingMarker {
  constructor({ map, building }) {
    this.map = map;
    this.building = building;

    const position = new google.maps.LatLng(building.lat, building.long);

    this.marker = new google.maps.Marker({
      position,
      map,
      label: building.number,
      icon: MapData.markers.pin
    });

    this.marker.addListener("click", () => {
      const url = `/buildings/${this.building.number}/apartments`;
      window.open(url);
    });
  }

  hide() {
    this.marker.setMap(null);
  }

  show() {
    this.marker.setMap(this.map);
  }
}
