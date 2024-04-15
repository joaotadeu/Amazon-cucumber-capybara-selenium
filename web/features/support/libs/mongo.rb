require "mongo"

Mongo::Logger.logger = Logger.new("/Users/joaotadeu/Documents/Workspace/Cucumber-web_api-ruby/web/log/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(name, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: name, user: user_id })
  end

  def get_user_id(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end
  
  def remove_all_equipos(email)
    user_id = get_user_id(email)
    @equipos.delete_many({ user: user_id })
  end

end

