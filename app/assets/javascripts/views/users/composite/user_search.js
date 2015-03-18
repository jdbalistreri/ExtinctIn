ExtinctIn.Views.UserSearch = Backbone.CompositeView.extend({

  tagName: "article",
  className: "user-search group",

  initialize: function (options) {
    this.query = options.query;
    this.searchResults = new ExtinctIn.Collections.SearchResults();
    this.searchResults.fetch({data: {query: this.query}});
    this.listenTo(this.searchResults, "sync", this.render);
  },

  template: JST["users/search"],

  events: {
    "submit form" : "search",
  },

  render: function () {
    var content = this.template({query: this.query});
    this.$el.html(content);

    this.searchResults.each(function (user) {
      var indexItem = new ExtinctIn.Views.UserIndexItem({model: user});
      this.addSubview(".search-results", indexItem);
    }.bind(this))

    return this;
  },

  search: function (event) {
    event.preventDefault();
    var query = this.$(".search-input").val();

    this.searchResults.fetch({
      data: {
        query: query
      },
    });
  },
})
