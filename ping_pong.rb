require "json"

class PingPong
  attr_accessor :users, :games

  def initialize
    load_users
    load_games
  end

  def find_user_by_name(name)
    # Improve this, must be in one line :)
    found_users = @users.select do |user|
      user["name"] == name
    end
    found_users[0]
  end

  def find_user_by_id(id)
    # Improve this, must be in one line :)
    found_users = @users.select do |user|
      user["id"] == id
    end
    found_users[0]
  end

  def add_game(player1, player2, score_player1, score_player2)
    @games << {
      "player_id1" => player1["id"],
      "player_id2" => player2["id"],
      "score_player1" => score_player1,
      "score_player2" => score_player2
    }
    save_games
  end

  def add_user(name)
    if !find_user(name)
      @users << {
        "id"  => @users.size + 1,
        "name" => name
      }
      save_users
    end
  end

  def display_games
    @games.each do |game|
      player1_name = find_user_by_id(game["player_id1"])["name"]
      player2_name = find_user_by_id(game["player_id2"])["name"]

      puts "#{player1_name} - #{game["score_player1"]}"
      puts "#{player2_name} - #{game["score_player2"]}"
      puts "***** END OF GAME *****"
    end
  end

  private

  def load_users
    File.open("./users.json", "r") do |file|
      @users = JSON.parse(file.read)
    end
  end

  def load_games
    File.open("./games.json", "r") do |file|
      @games = JSON.parse(file.read)
    end
  end

  def save_users
    File.open("./users.json", "w") do |file|
      file.write(JSON.generate(@users))
    end
  end

  def save_games
    File.open("./games.json", "w") do |file|
      file.write(JSON.generate(@games))
    end
  end
end

ping_pong = PingPong.new
ping_pong.display_games
# ping_pong.add_user("Pierre")
# ping_pong.add_user("Gonzalo")

# player1 = ping_pong.find_user("Pierre")
# player2 = ping_pong.find_user("Gonzalo")

# ping_pong.add_game(player1, player2, 21, 17)
