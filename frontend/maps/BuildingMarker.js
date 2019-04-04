export default class BuildingMarker {
  constructor({ map, building }) {
    this.map = map;
    this.building = building;

    const position = new google.maps.LatLng(building.lat, building.long);

    const marker = new google.maps.Marker({
      position,
      map,
      // label: building.number,
      icon: MapData.markers.pin
    });
    this.marker = marker;
    const url = `/buildings/${this.building.number}/apartments`;

    const contentString = `
    <div>
      <p><b>Prédio ${building.number}</b></p>
      <a target="blank" href="${url}">${building.address}</a>

      <p>
      Apartamentos: ${building.number_of_apartments}
      </p>
      <p>
      Cartas: ${building.call_options.indexOf("phone") >= 0 ? "Sim" : "Não"}
      <br/>
      Intefone: ${
        building.call_options.indexOf("intercom") >= 0 ? "Sim" : "Não"
      }
      <br/>
      </p>
    </div>
    `;
    const infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    marker.addListener("click", function() {
      infowindow.open(map, marker);
    });
  }

  hide() {
    this.marker.setMap(null);
  }

  show() {
    this.marker.setMap(this.map);
  }
}
