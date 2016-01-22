export default Ember.Component.extend({
  classNames:  ['bar-chart'],

  draw: function() {
    var grouped = _.groupBy(this.get('data'), 'status');
    this.set('stats', grouped);
  }.on("didInsertElement"),
});
