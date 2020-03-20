require 'kickball_scoreboard'

# Imagine you work at a video game company
# Your new to the team and your boss has put you on an unfinished project to build an arcade kickball game

# Your new team has put you in charge with working on the scoreboard for the game
# The scoreboard in the game keeps track of the kickball box score
# Kickball has some specific scoring rules that are very similar to baseball and softball.
# If you would like to familiarize yourself with some of the basics of kickball please take the time to do some research
#
# RULES
# In kickball there are 4 bases. In the actual game these form a square or a diamond
#
#        2nd
#      /     \
#     /       \
#    /         \
# 3rd          1st
#    \         /
#     \       /
#      \     /
#       4th/home
#
# Players advance from one base to the next. There is a base at each corner of the square.
# When a players advances all the way around and gets to the 4th base, where they started (a.k.a. home plate), the player scores a run
# A players starts at home plate and has an opportunity to kick the ball and we shall refer to this player as a "kicker"
# Only one player can occupy a single base at a time
#
#
# EVENTS
# Currently the scoreboard for the game only handles 5 event types: "S", "D", "T", "HR", "K"
# "S" - represents a single which means the kicker advances to 1st base, all base runners move forward 1 base
# "D" - represents a double which means the kicker advances to 2nd base, all base runners move forward 2 bases
# For example:
# If there is a player on 2nd base and the kicker kicks the ball and gets a double,
# the player on 2nd base advances home and scores a run
# The current kicker advances to 2nd base
#
# "T" - represents a triple which means the kicker advances to 3rd base, all base runners move forward 3 bases: effectively all base runners score runs
# "HR" - represents a home run which means the kicker advances to the 4th base or home plate and scores a run: all base runners also score runs
# "K" - represents a strike out. An out is recorded.
#
#
# INNINGS AND OUTS
# There are two teams in a kickball game. Each team alternates kicking within an "inning"
# An inning is composed of 2 halves. A top half and a bottom half.
# The away team kicks in the top half. The home team kicks in the bottom half.
# After 3 outs the half inning is over. All bases are cleared. And the next half inning starts for the opposite team.
# The only way to record an out is when the kicker strikes out which is represented by a "K"
#
#
# PROBLEM STATEMENT
# The engineer who worked on this project before you has since left the team and the project is not complete.
# Right now the scoreboard can only keep track of one inning.
# In this arcade game we need to be able to complete games after THREE innings.
# The game can end in a tie.
# Right now the valid events are: ["S", "D", "T", "HR", "K"]
#
# There is a get_box_score method that is incomplete. It only works for ONE inning of play.
# We need to build out the scoreboard service to handle THREE innings and the end of the game.
# We need to be able to ask the scoreboard service for the box score mid way through a game.
#
# Here are the possible return values for the box score object
# box_score {
#   away_team: number of runs scored by the away team in string form
#   home_team: number of runs scored by the home team in string form
#   status: ["in progress", "home team wins", "away team wins", "tie game"]
#   current_inning: numbers "1" through "3" OR "game over"
# }
#
# Here are the goals for this finishing the project
# 1. Add new functionality to meet requirements of the project
# 2. Ensure new functionality is well tested
# 3. Make sure the scoreboard service is readable and easy to understand
# 4. Make sure tests are readable and easy to understand


describe "KickballScoreboard" do
  let(:test_cases) {
    [
        {
            sequence: ["S", "D", "T", "HR"],
            box_score: {
                away_team: "4",
                home_team: "0",
                status: "in progress",
                current_inning: "1",
            }
        },
        {
            sequence: ["K", "D", "S", "T", "K", "K"],
            box_score: {
                away_team: "2",
                home_team: "0",
                status: "in progress",
                current_inning: "1",
            }
        },
        {
            sequence: ["HR", "K", "S", "S", "S", "K"],
            box_score: {
                away_team: "1",
                home_team: "0",
                status: "in progress",
                current_inning: "1",
            }
        },
        {
            sequence: ["HR", "K", "K", "S", "K", "HR", "S", "S", "D", "K", "K"],
            box_score: {
                away_team: "1",
                home_team: "2",
                status: "in progress",
                current_inning: "1",
            }
        },
    ]
  }

  it "works for the existing test cases" do
    test_cases.each do |test_case|
      inning_service = KickballScoreboard.new
      test_case[:sequence].each do |event|
        inning_service.handle_event(event)
      end

      expect(inning_service.get_box_score).to eq(test_case[:box_score])
    end
  end
end

# BONUS
# Can we keep track of hits for each team
# Can we add hitting team to the box score
# Can we add a new type of event called a sacrifice where the kicker is out but all base runners advance one