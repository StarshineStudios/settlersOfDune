enum HexType {
  desert,
  sandstone,
  flora,
  fauna,
  alloy,
  water,
  spice,
}

enum GameState {
  setup, //when a player is placing

  roll, //when rolling
  fremenPlace,
  sandwormRoll,
  sandwormPlace,
  postRoll,
  end,
}
