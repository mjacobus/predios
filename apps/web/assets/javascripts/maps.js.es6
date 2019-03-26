const initMap = () => {

  const average = averageLocation(MapData.buildings)
  const center = {lat: average.lat, lng: average.lng}

  const map = new google.maps.Map(document.getElementById('map'), {
    center,
    zoom: 15
  });

  addMarkers(MapData.buildings, map);
}


const averageLocation = (buildings) => {
  const latitudes = [];
  const longitudes = []

  buildings.forEach((building) => {
    if (building.has_geolocation) {
      latitudes.push(building.lat);
      longitudes.push(building.long);
    }
  });


  const lat = (Math.min.apply(null, latitudes) + Math.max.apply(null, latitudes)) / 2;
  const lng = (Math.min.apply(null, longitudes) + Math.max.apply(null, longitudes)) / 2;

  return { lat, lng };
}

const addMarkers = (buildings, map) => {
  buildings.map(building => {
    const position = new google.maps.LatLng(building.lat, building.long)

    new google.maps.Marker({
      position,
      map,
      label: building.number
    });
  })
}
