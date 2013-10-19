var Geo = {
  _userGeo: null,
  _watchId: null,
  get: function(successCallback) {
    if (this._userGeo) {
      return successCallback(this._userGeo);
    }
    navigator.geolocation.getCurrentPosition(
      function(position){
        Geo._userGeo = position;
        successCallback(position);
      },
      this.error, this.options
    );
  },
  watch: function(successCallback) {
    this._watchId = navigator.geolocation.watchPosition(
      function(position) {
        successCallback(position);
    },
    this.error, this.options);
  },
  clearWatch: function() {
    navigator.geolocation.clearWatch(this._watchId);
    this._watchId = null;
    return true;
  },
  _error: function(error) {
    console.warn('ERROR(' + error.code + '): ' + error.message);
  },
  _options: function() {
    //TODO: options as params
    return { enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0 }
  }
};