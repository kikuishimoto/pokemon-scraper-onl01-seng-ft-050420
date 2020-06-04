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
  def self.find(num, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE id=?", [num])
    new_pokemon = self.new(pokemon)
    new_pokemon.id = pokemon[0][0]
    new_pokemon.name = pokemon[0][1]
    new_pokemon.type = pokemon[0][2]
    return new_pokemon
  end
end
