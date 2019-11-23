# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movie.create([
  { title: "The Lord of the Rings: The Fellowship of the Ring",
    plot: "Fellowship of the Ring starts their campaign" },
  { title: "Star Wars: Episode I – The Phantom Menace", plot: "Story about Anakin's childhood" }
])

Season.create([
  {
    title: "Game of Thrones",
    number: 1,
    plot: <<-TXT.squish
      The Hand of the King is dead, and King Robert goes to his friend, Lord Eddard Stark,
      Warden of the North...
    TXT
  },
  {
    title: "Game of Thrones",
    number: 2,
    plot: <<-TXT.squish
      The season follows the dramatic death of Lord Eddard Stark, with all of the Starks being
      separated across Westeros...
    TXT
  }
])

season = Season.find_by(number: 1)

Episode.create([
  {
    title: "The Kingsroad",
    number: 2,
    season: season,
    plot: <<-TXT.squish
      Having accepted his new role as King's Hand, Ned leaves Winterfell with his daughters
      Sansa and Arya, while Catelyn stays behind to tend to Bran. The unconscious Bran is
      attacked by an assassin, but his direwolf saves him...
    TXT
  },
  {
    title: "Winter Is Coming",
    number: 1,
    season: season,
    plot: <<-TXT.squish
      In the Seven Kingdoms of Westeros, a soldier of the ancient Night's Watch order survives
      an attack by supernatural creatures known as the White Walkers...
    TXT
  }
])

season = Season.find_by(number: 2)

Episode.create([
  {
    title: "The Night Lands",
    number: 2,
    season: season,
    plot: <<-TXT.squish
      Returning to Pyke Island after nine years as the Starks' ward, Theon is reunited with his
      sister, Yara, and his father, Balon, who despises Theon's acquired Northern ways. Balon
      plots to win back his crown by force...
    TXT
  },
  {
    title: "The North Remembers",
    number: 1,
    season: season,
    plot: <<-TXT.squish
      To Cersei's dismay, Tyrion becomes acting Hand of the King at King's Landing. At Dragonstone,
      Stannis proclaims allegiance to Melisandre's God of Light, and publicly claims the Iron
      Throne. He also reveals Joffrey's bastardy...
    TXT
  }
])

Content.all.each do |content|
  PurchaseOption.create(quality: "sd", price: 199, content: content)
  PurchaseOption.create(quality: "hd", price: 399, content: content)
end

User.create(email: "customer@email.com")
