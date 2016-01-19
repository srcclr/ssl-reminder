import SslReminder from "../models/ssl-reminder";

export default Discourse.Route.extend({
  model() {
    return PreloadStore.getAndRemove('domains', () => {
      return Discourse.ajax(Discourse.getURL("/ssl-reminder/domains"));
    }).then((data) => {
      return SslReminder.createFromJson(data);
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
});
