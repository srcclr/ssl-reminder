Ember.Handlebars.registerBoundHelper('percents', function(top, bottom) {
  if (top === 0 || bottom === 0) { return 0; }
  return bottom / top * 100;
});
