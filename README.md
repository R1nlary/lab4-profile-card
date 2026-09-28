# LAB4 — Interactive Like & Follower Profile Card

A single-screen Flutter app: a profile card with a Follow toggle, a Like
button with a counter, and a Reset button. All state is managed with
`setState()`.

## Run

```bash
flutter pub get
flutter run
```

(or run on a specific device: `flutter run -d chrome`, `-d ios`, `-d android`)

## What it does

* **Avatar & profile details** — a `CircleAvatar` with the person's name and
  a short bio.
* **Follow / Following toggle** — `ElevatedButton` that flips a boolean
  (`isFollowing`) on tap and changes both its label and its color.
* **Like / Dislike buttons** — a heart `IconButton` and a thumb-down
  `IconButton`, each toggling its own boolean and moving its own counter
  `+1` when active and `-1` when turned off. Liking cancels an existing
  dislike (and vice versa), the same way YouTube's like/dislike pair works.
* **Reset button** — restores follow, like and dislike state (both booleans
  and both counters) to their original default values.

Every state change goes through `setState()`, so the widget tree rebuilds
and the UI stays in sync with the underlying booleans/counters.

## Tests

```bash
flutter test
```

Covers the Follow toggle, the like counter, the dislike counter, the
like/dislike mutual exclusivity, and Reset restoring the default state.
