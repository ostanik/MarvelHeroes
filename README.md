# MarvelHeroes
This is a sample app that uses Marvel's API to fetch a list of heroes, show the hero detail and, also add them to favorite.

## User Stories 
### 1. As a user, I want to see a list of Marvel Super Heroes, So I can pick the one I like

**Acceptance criteria:**

Each element of the list should have the image of its super hero.
This list should leverage the use of pagination (20 heroes per page).
At each page load, show the user some feedback by displaying a loader.

### 2. As a user, I want to navigate to a Hero Detail View, So I can take a look at the details of any Super Hero

**Acceptance criteria:**

You must include a custom view controller transition.
User should be able to see the following details of the following entities:

  * The details of 3 comics (if any) that this super hero takes part in. These details must at least include name and description of
the comic.
  * The details of 3 events (if any) that this super hero takes part in. These details must at least include name and description of
the event.
  * The details of 3 stories (if any) that this super hero takes part in. These details must at least include name and description of
the story.
  * The details of 3 series (if any) that this super hero takes part in. These details must at least include name and description of
the series.

### 3. As a user, I want to easily find any Super Hero by their name, So I can avoid scrolling through lists of Super Heroes

**Acceptance criteria:**

  * Search query should be done by the Super Hero's name.
  * Search query should be done using the search REST endpoint, NOT a local search/filter.

### 4. As a user, I want to favourite a Super Hero, So I can see all favourite Super Heroes while quickly glancing through Listing and Hero Detail Views**

**Acceptance criteria:**

  * Favourite UI components should be included in both Listing and Hero Detail Views.
  * Favourite Heroes should persist between app sessions.


## References:
<div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
