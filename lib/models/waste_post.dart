class WastePost {
  int numItems;
  String photoURL;
  double latitude;
  double longitude;
  String datePosted;

  WastePost({
    this.numItems,
    this.photoURL,
    this.latitude,
    this.longitude,
    this.datePosted
  });

  WastePost.fromMap(Map map) {
    this.numItems = map['quantity'];
    this.photoURL = map['imageURL'];
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
    this.datePosted = map['date'];
  }
  
  validateLatLon() {
    if (this.latitude > 90 || this.latitude < -90) {
      this.latitude = this.latitude % 90;
    }

    if (this.longitude > 180 || this.longitude < -180) {
      this.longitude = this.longitude % 180;
    }
  }
}