require_relative './spec_helper.rb'
require_relative '../lib/characters/player_character.rb'
require_relative '../lib/dungeon/map/tiles/room.rb'

describe PlayerCharacter do
  character = PlayerCharacter.new
  starting_point = [0, 0]
  second_point = [-1, 0]
  room = Room.new(starting_point)
  room2 = Room.new(second_point)

  context 'When a character is on a map' do
    before(:each) do
      allow(room).to receive(:grid_point).and_return([0, 0])
      allow(room).to receive(:connections).and_return(second_point => room2)
      allow(room).to receive(:directions).and_return('west' => second_point)

      allow(room2).to receive(:grid_point).and_return([-1, 0])
      allow(room2).to receive(:connections).and_return(starting_point => room)
      allow(room2).to receive(:directions).and_return('east' => starting_point)
      starting_tile = room
      character.get_on_map(starting_point, starting_tile)
    end

    it 'sets the location properly and updates the character map when placed on it initially.' do
      expect(character.location).to be(room)
    end

    it 'creates the character map when placed on it initially.' do
      character_map = { [0, 0] => room, [-1, 0] => room2, [0, -1] => 'wall', [1, 0] => 'wall', [0, 1] => 'wall' }
      expect(character.map).to eq(character_map)
    end

    context 'when a character moves on a map' do
      before(:each) do
        character.move_on_map(room2)
      end

      it 'moves the location to the new tile' do
        expect(character.location).to be(room2)
      end

      it 'updates the character map' do
        character_map = { [0, 0] => room, [-1, 0] => room2, [0, -1] => 'wall', [1, 0] => 'wall', [0, 1] => 'wall',
                          [-2, 0] => 'wall', [-1, -1] => 'wall', [-1, 1] => 'wall' }
        expect(character.map).to eq(character_map)
      end
    end
  end
end
