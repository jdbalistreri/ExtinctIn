# Plugged In

Plugged In is a professional networking site built in Rails and Backbone
#####<a href="http://www.plugged-in.io" target="_blank">Live Link</a>

### Challenge Overview
#####Problem:
Implement the core functionality of a professional networking site (e.g. LinkedIn)
#####Solution:
Full stack solution uses a RESTful Rails API that delivers JSON to Backbone front­end (feature and implementation detail below)

### Features
- Create accounts and sessions (log in)
- Create profiles with personal information and add past job/school experiences
- Edit profiles in place by double clicking the text
- Request to connect with other users and view connections
- Send messages to other users
- Search for users
- Take a website tour on login or sign in with a demo account

### Implementation
#### Profiles, Users, and Experiences
- Form views on profile edit in place by inheriting from [toggleable form superclass][toggleable]
- A user's experiences are [sent down][user-jbuilder] with user data as JSON and [parsed][user-parse] into separate Backbone collections
- [User model][user-model] has built in methods to generate realistic seed data

#### Connections
- Connections rely on two [database tables][schema] (connections and user_connections) to cleanly implement two-way friendships
- [Connect button subview][connect-button] allows users to issue connection requests across various user views; permits options available based on a user's connection status with the current user
- [Connected users index view][connected-users-index] displays a user's approved connections while paginating results

#### Messages/Search
- Navigation between [inbox][inbox-view] pages occurs using the [router][router] and a getOrFetch method to ensure data persists across hard refreshes
- [API Static Controller][search_controller] processes search query with PGSearch and paginates results with Kaminari
- Search results view uses [infinite scroll][search-results] to improve load time and UX

### Technical Choices
- Notifications and dropdown menus on navigation bar
- Degrees of connection
- Statistics on who has viewed a user profile (D3 for data visualization)

##About the Developer
I am an NYC-based web developer with experience in Rails and JavaScript. After graduating from Dartmouth in 2013, I worked as an analytic strategy consultant. During that time I began teaching myself to code and ultimately decided to pursue programming full time.

####Online Presence
- [Personal website][personal]
- [Resume][resume]
- [LinkedIn][linkedin]
- [Tumblr][tumblr]
####Other Projects
- [Chess in Ruby][chess]
- Asteroids in JS and Canvas [live][asteroids] [github][asteroids-github]

[user-jbuilder]: ./app/views/api/users/show.json.jbuilder
[user-model]: ./app/models/user.rb
[user-parse]: ./app/assets/javascripts/models/user.js
[toggleable]: ./app/assets/javascripts/utils/toggleable_form.js
[connect-button]: ./app/assets/javascripts/views/connect_button.js
[schema]: ./db/schema.rb
[connected-users-index]: ./app/assets/javascripts/views/connected_users_index.js
[inbox-view]: ./app/assets/javascripts/views/inbox_show.js
[router]: ./app/assets/javascripts/routers/router.js
[search-results]: ./app/assets/javascripts/views/users/composite/user_search.js
[search_controller]: ./app/controllers/api/static_controller.rb
[chess]: https://github.com/jdbalistreri/Chess
[personal]: http://www.joebalistreri.net/
[resume]: https://drive.google.com/file/d/13_K04Uy3gyKyTTF1SK_sSRadxEHW1FTFuaZciw9Km2R4_3po9riI8oF7-JSSapEUziy_19doEK5oo_K2/view
[tumblr]: http://jdbalistreri.tumblr.com/
[linkedin]: https://www.linkedin.com/in/jdbalistreri
[asteroids]: http://www.joebalistreri.net/AsteroidsJS/
[asteroids-github]: https://github.com/jdbalistreri/AsteroidsJS
