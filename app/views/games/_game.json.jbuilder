json.extract! game, :id, :name, :goal, :created_at, :updated_at
json.url game_url(game, format: :json)
