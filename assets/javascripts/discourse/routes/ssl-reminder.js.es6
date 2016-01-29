import SslReminder from "../models/ssl-reminder";
import RedirectIfNotLoggedIn from "../mixins/redirect-if-not-logged-in";

export default Discourse.Route.extend(RedirectIfNotLoggedIn, {
  redirect() { return this.redirectIfNotLoggedIn("/projects/ssl-reminder"); },

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
