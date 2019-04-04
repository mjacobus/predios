const onError = error => {
  console.log("Cannot get current location");
  console.log(error);
};

const addCurrentLocationMarker = ({ marker, map, navigator }) => {
  console.log("updating locatin");
  const onSuccess = addMarker({ marker, map, navigator });
  navigator.geolocation.getCurrentPosition(onSuccess, onError);
  setTimeout(() => addCurrentLocationMarker({ marker, map, navigator }), 5000);
};

const addMarker = ({ map, marker }) => position => {
  console.log("Updating position");
  position = new google.maps.LatLng(
    position.coords.latitude,
    position.coords.longitude
  );

  marker.setPosition(position);
};

export default class CurrentLocationMarker {
  constructor({ map, navigator }) {
    const marker = new google.maps.Marker({
      // position,
      map,
      // label: building.number,
      icon: MapData.markers.currentLocation
    });

    addCurrentLocationMarker({ marker, map, navigator });
  }
}
