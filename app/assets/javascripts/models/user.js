ExtinctIn.Models.User = Backbone.Model.extend({
  urlRoot: "api/users",

  parse: function (response) {
    if (response.jobs) {
      this.jobs().add(response.jobs)
      delete response.jobs
    }

    if (response.schools) {
      this.schools().add(response.schools)
      delete response.schools
    }

    if (response.cu_connection) {
      this.cu_connection = new ExtinctIn.Models.Connection(response.cu_connection);
      delete response.cu_connection;
    }

    return response
  },

  toJSON: function () {
    return {
      user: _.clone(this.attributes)
    }
  },

  jobs: function () {
    if (!this._jobs) {
      this._jobs = new ExtinctIn.Collections.Experiences([], {type: "Job"})
    }

    return this._jobs
  },

  schools: function () {
    if (!this._schools) {
      this._schools = new ExtinctIn.Collections.Experiences([], {type: "School"})
    }

    return this._schools
  },
})
