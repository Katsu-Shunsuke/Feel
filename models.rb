require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.db'
  )
end

class User < ActiveRecord::Base
  has_secure_password
end

class Post < ActiveRecord::Base

end

class Follow < ActiveRecord::Base

end

class Property < ActiveRecord::Base

end
