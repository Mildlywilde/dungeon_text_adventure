class Dungeon
	attr_accessor :player

	def initialize(player_name)
		@player = Player.new(player_name)
		@rooms = []
		$complete = false
	end

	def add_room(reference, name, description, connections)
		@rooms << Room.new(reference, name, description, connections)
	end

	def start(location)
		@player.location = location
		show_current_description
	end

	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
	end

	def find_room_in_dungeon(reference)
		@rooms.detect { |room| room.reference == reference}
	end

	def find_room_in_direction(direction)
		find_room_in_dungeon(@player.location).connections[direction]
	end

	def go(direction)
		puts "You go #{direction}"
		@player.location = find_room_in_direction(direction)
		show_current_description
	end

	class Player
		attr_accessor :name, :location
		def initialize(name, location=nil)
			@name = name
			@location  = location
		end
	end

	class Room
		attr_accessor :reference, :name, :description, :connections
		
		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end

		def full_description
			"#{@name}: \n\n#{@description}"
		end
	end
end

puts "What is your name?"

lost_at_sea = Dungeon.new(gets.chomp)
lost_at_sea.add_room(:ocean, "Ocean", "Undulating expanses of water stretch out in all directions, you think you see something on the horizon ahead...", {:north => :island})
lost_at_sea.add_room(:island, "Island", "A muddy island rises out of the sea, beneath the oozing mud you can see what looks to be the remnants of a civilisation but something about the architecture unsettles you.", {:south => :ocean, :west => :temple})

lost_at_sea.start(:ocean)

while $complete == false do
	puts "what would you like to do?"
	case gets.chomp.downcase
	when "go west"
		lost_at_sea.go(:west)
	when "go north"
		lost_at_sea.go(:north)
	when "go south"
		lost_at_sea.go(:south)
	when "go east"
		lost_at_sea.go(:east)
	else puts "I don't understand"
	end

end
