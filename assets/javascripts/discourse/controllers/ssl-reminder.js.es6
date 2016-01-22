import BufferedContent from 'discourse/mixins/buffered-content';
import { popupAjaxError } from 'discourse/lib/ajax-error';


export default Ember.Controller.extend(BufferedContent, {
  addMode: false,

  actions: {
    addDomain() {
      this.set('addMode', true);
    },

    save() {
      let attrs = this.get('buffered').getProperties('name', 'url');

      this.get('model').addDomain(attrs).then((res) => {
        this.set('addMode', false);
        this.commitBuffer();
      }).catch(popupAjaxError);
    },

    cancel() {
      this.rollbackBuffer();
      this.set('addMode', false);
    }
  }
});
