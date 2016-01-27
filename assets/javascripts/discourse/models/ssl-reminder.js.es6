import Domain from "./domain";

let SslReminder = Discourse.Model.extend({
  addDomain(data) {
    return Discourse.ajax("/ssl-reminder/domains", {
      type: "POST",
      data: { domain: data }
    }).then((res) => { this.domains.pushObject(Domain.createFromJson(res.domain)); });
  },

  toggleDomainNotification(domain_id) {
    return Discourse.ajax("/ssl-reminder/domains/" + domain_id + "/toggle_notification" , { type: "PUT" });
  }
});

SslReminder.reopenClass({
  createFromJson(json) {
    return this.create({
      domains: _.map(json.ssl_reminder_domains, (domain) => { return Domain.createFromJson(domain); })
    });
  }
});

export default SslReminder;
