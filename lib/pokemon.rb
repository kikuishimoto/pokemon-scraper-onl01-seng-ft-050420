class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id
  def initialize(id: nil, name:, type:, db:)
    @ID = id
    @name = name
    @type = type
    @db = db
  end
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES (?,?)
    SQL
    db.execute(sql, name, type)
    @ID = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon
      WHERE id = ?
    SQL
    pokemon = db.execute(sql, id)
    new_pokemon = self.new(id: pokemon[0][0], name: pokemon[0][1] , type: pokemon[0][2], db: db)
        # new_pokemon.id = pokemon[0][0]
        # new_pokemon.name = pokemon[0][1]
        # new_pokemon.type = pokemon[0][2]
        # new_pokemon.db = db
    new_pokemon
  end
end
