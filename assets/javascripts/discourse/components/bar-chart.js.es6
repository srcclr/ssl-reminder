export default Ember.Component.extend({
  classNames:  ['barchart'],

  groupedResults: function () {
    let result = [];

    this.get('data').forEach(item => {
      let hasType = result.findBy('status', item.get('status'));

      if (!hasType) {
        result.pushObject(Ember.Object.create({
          status: item.get('status'),
          contents: []
        }));
      }

      result.findBy('status', item.get('status')).get('contents').pushObject(item);
    });

     return result;
  }.property('content.[]')
});
