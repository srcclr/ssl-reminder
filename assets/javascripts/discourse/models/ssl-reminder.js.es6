import Domain from "./domain";

const FIXTURES = [
  {
    id: 0,
    name: 'test',
    expiration_date: '2016-12-12'
  }
];

let SslReminder = Discourse.Model.extend({
  addDomain(data) {
    return Discourse.ajax("/ssl-reminder/domains", {
      type: "POST",
      data: { domain: data }
    }).then((res) => { this.domains.pushObject(Domain.create(res.domain)); });
  }
});

SslReminder.reopenClass({
  createFromJson() {
    return this.create({
      domains: _.map(FIXTURES, (domain) => { return Domain.create(domain); }),
    });
  }
});

export default SslReminder;
