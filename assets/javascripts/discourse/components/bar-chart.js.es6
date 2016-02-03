export default Ember.Component.extend({
  classNames:  ['barchart'],

  groupedResults: function () {
    let result = [];
    console.log("Data: ");
    console.log(this.get("data"));
    console.log(this.get("parentController.model.domains"));
    console.log(this);
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
  }.property("data.[]")
});
