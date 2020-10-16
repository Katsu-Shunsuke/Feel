ActiveRecord::Base.establish_connection("sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_secure_password
end

class Post < ActiveRecord::Base

end

class Follow < ActiveRecord::Base

end

class Property < ActiveRecord::Base

end
