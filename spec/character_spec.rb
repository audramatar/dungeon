require_relative './spec_helper.rb'
require_relative '../lib/characters/character.rb'

describe Character do
  context 'When altering a character party' do
    character = Character.new
    ally = Character.new

    context 'when a character adds someone to their party' do
      character.add_ally_to_party(ally)

      it 'should add the ally to the end of the party' do
        expect(character.party).to eq([character, ally])
      end

      it "should update ally's party to match player's party" do
        expect(ally.party).to eq([character, ally])
      end

      it "should update ally's party number to the last spot in the party" do
        expect(ally.party_number).to eq(2)
      end
    end
  end
  context 'When a character takes damage' do
    character = Character.new
    damage = character.hp / 2 - 1

    before(:each) do
      character.heal(character.max_hp)
    end

    it 'their hp decreases according to damage' do
      expect(character.hp).to eq(character.max_hp)
      character.take_damage(damage)
      expect(character.hp).to eq(character.max_hp - damage)
    end

    it 'their alive status changes if their health reaches 0' do
      damage = character.max_hp
      expect(character.alive).to be(true)
      character.take_damage(damage)
      expect(character.hp).to be(0)
      expect(character.alive).to be(false)
    end

    it 'their hp does not go below 0' do
      damage = character.max_hp
      character.take_damage(damage) # hit the max damage twice -- sure to go over
      character.take_damage(damage)
      expect(character.hp).to be(0)
    end
  end

  context 'When a character heals' do
    character = Character.new
    points = character.hp / 2

    before(:each) do
      character.take_damage(character.hp / 2 + 1)
    end

    it 'their hp increases according to points' do
      previous_hp = character.hp
      character.heal(points)
      expect(character.hp).to eq(previous_hp + points)
    end

    it 'their alive status changes if their health goes above 0' do
      character.take_damage(character.max_hp)
      expect(character.alive).to be(false)
      character.heal(points)
      expect(character.hp).to be(points)
      expect(character.alive).to be(true)
    end

    it 'their hp does not go above max_hp' do
      points = character.max_hp
      character.heal(points) # Heal the max amount twice -- sure to be over
      character.heal(points)
      expect(character.hp).to be(character.max_hp)
    end
  end
end
