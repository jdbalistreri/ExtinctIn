ExtinctIn.Views.MessageForm = Backbone.View.extend({

  tagName: "form",
  template: JST["messages/form"],

  events: {
    "submit" : "handleSubmit"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var attrs = this.$el.serializeJSON();
    var that = this;

    this.model.save(attrs, {
      success: function (model, response) {
        this.collection.add(model, {merge: true});
        Backbone.history.navigate("#inbox/messages/" + model.id, {trigger: true});
      }.bind(this),
    })
  },

})