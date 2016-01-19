const DATE_FORMAT = "YYYY-MM-DD";

const EXPIRATION_DAYS_BREAKPOINTS = [
  {
    name: 'safe',
    value: 30
  },
  {
    name: 'warning',
    value: 7
  },
  {
    name: 'danger',
    value: 0
  }
];

let Domain = Discourse.Model.extend({
  status: Em.computed('expiration_date', function(){
    let now = moment().startOf('day');
    let expirationDate = moment(this.get('expiration_date'), DATE_FORMAT);
    let daysRemaining = moment(expirationDate).diff(now, 'days');

    return _(EXPIRATION_DAYS_BREAKPOINTS)
      .filter((b) => daysRemaining > b.value)
      .max((b) => b.value)
      .value();
  }),

  destroy() {
    return Discourse.ajax('/ssl-reminder/domains/' + this.get('id'), { type: 'DELETE' });
  },

});

Domain.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      name: json.name,
      url: json.url,
      expiration_date: json.expiration_date
    });
  }
});

export default Domain;
