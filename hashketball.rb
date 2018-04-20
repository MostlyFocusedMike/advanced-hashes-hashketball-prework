# Write your code here!
require 'pry'
require 'benchmark'
def game_hash() 
# game_hash{home{teamname"",colors[],players{stats: ints}}
  return {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black","White"],
      players: {
        "Alan Anderson" => {
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        "Reggie Evans" => {
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        "Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        "Mason Plumlee" => {
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 12,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        "Jason Terry" => {
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      }
    },
    away:{
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: {
        "Jeff Adrien" => {
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        "Bismak Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 7,
          blocks: 15,
          slam_dunks: 10
        },
        "DeSagna Diop" => {
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        "Ben Gordon" => {
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        "Brendan Haywood" => {
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 22,
          blocks: 5,
          slam_dunks: 12
        }
      }
    }
  }
end 

# after realizing they never said you can't make extra 
# helper methods 

def players 
  # hash of {player_name: stats{}}
  home = game_hash[:home][:players]
  away = game_hash[:away][:players]
  return home.merge(away)
end

def find_player(player) 
  # given their name, it returns their stats hash
  players.find { |name,stats| name == player }[1]
end

def find_team(team)
  # given their name, it returns the team's assets hash
  game_hash.find { |locale,assets| game_hash[locale][:team_name] == team }[1]
end

def num_points_scored(player)
  # given player's total points scored 
  return players[player][:points]
end

def shoe_size(player)
  # given player's total shoe size 
  return players[player][:shoe]
end

def team_colors(team)
  #return array of given teams colors 
  return find_team(team)[:colors]
end

def team_names()
  # returns an array of the team names 
  return game_hash.map {|locale,assets| game_hash[locale][:team_name]}
end

def player_numbers(team)
  # returns all player numbers of a given team name
  find_team(team)[:players].map {|name,stats| stats[:number]}
end  

def player_stats(player)
  #return stats hash of a given player 
  return players[player]
end

def big_shoe_rebounds()
  # return the rebounds of the player with the biggest shoe
  players.sort_by { |player,stats| stats[:shoe] }[-1][1][:rebounds]
end


# bonus methods that were attempted after I realized the right
# way to go about this lab with helper methods 



def most_points_scored()
  # returns the name of the player with the highest score
  players.sort_by {|name,stats|stats[:points]}[-1][0] 
end 

def winning_team
  # returns the name of the team that scored the most points 
  game_hash.sort_by do |locale,assets|
    assets[:players].map {|k,stats| stats[:points] }.reduce(0, :+)
  end[-1][0]
end

def player_with_longest_name
  # returns the longest name of all players
  players.sort_by { |name,v| name.length }[-1][0]
end

def long_name_steals_a_ton?
  # true if the longest named player also stole the most, false if not
  players.none? do |name,stats| 
    find_player(player_with_longest_name)[:steals] < stats[:steals]
  end
end 




def player_by_number(num) 
  # enter number return players name 
  return "That's not a number" unless num.class == Fixnum
  player = players.find { |name,stats| stats[:number] == num }
  return player ? player[0] : "No player has that number"
end

binding.pry





















# OLD METHODS BEFORE HELPERS 
# def shoe_size(player)
#   game_hash.each do |location,stats|
#     if game_hash[location][:players].keys.include?(player)
#       return game_hash[location][:players][player][:shoe]
#     end
#   end
# end


# def num_points_scored(player)
#   if game_hash[:home][:players].keys.include?(player)
#     return game_hash[:home][:players][player][:points]
#   else 
#     return game_hash[:away][:players][player][:points]
#   end
# end

# def shoe_size(player)
#   game_hash.each do |location,stats|
#     if game_hash[location][:players].keys.include?(player)
#       return game_hash[location][:players][player][:shoe]
#     end
#   end
# end


# def player_stats(player)
#   #return stats hash of a given player 
#   return players[player]
#   game_hash.each do |location,value|
#     if game_hash[location][:players].include?(player) 
#       return game_hash[location][:players][player]
#     end
#   end
# end

# def big_shoe_rebounds()
#   shoe = 0
#   player = ""
#   game_hash.each do |location,value|
#     game_hash[location][:players].each do |name,stats|
#       if game_hash[location][:players][name][:shoe] > shoe
#         shoe = game_hash[location][:players][name][:shoe]
#         player = name
#       end
#     end
#   end
  
#   if game_hash[:home][:players].keys.include?(player)
#     return game_hash[:home][:players][player][:rebounds]
#   else 
#     return game_hash[:away][:players][player][:rebounds]
#   end
# end
