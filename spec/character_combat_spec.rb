require 'require_all'
require_relative './spec_helper.rb'
require_rel '../lib/characters'

describe EnemyCharacter do
  context 'When a character with ai' do
    enemy = EnemyCharacter.new
    opponent = EnemyCharacter.new

    context 'attacks' do
      attack_object = enemy.attack([opponent])

      it 'returns a valid attack object' do
        expect(attack_object.count).to eq(4)
        expect(attack_object[:name]).to eq(enemy.name)
        expect(attack_object[:target]).to eq(opponent)
        expect(attack_object[:attack]).to be_a(Integer)
        expect(attack_object[:damage]).to be_a(Integer)
      end
    end

    context 'defends' do
      attack_object = { name: 'test', target: opponent, attack: 10, damage: 2 }
      message = enemy.defend(attack_object)
      it 'returns a message' do
        expect(message).to be_a(String)
      end
    end
  end
end

describe PlayerCharacter do
  context 'When a controlled character attacks' do
    player = PlayerCharacter.new
    opponent = EnemyCharacter.new
    context 'attacks' do
      it 'returns a valid attack object' do
        allow(player).to receive(:gets).and_return('1')
        attack_object = player.attack([opponent])

        expect(attack_object.count).to eq(4)
        expect(attack_object[:name]).to eq(player.name)
        expect(attack_object[:target]).to eq(opponent)
        expect(attack_object[:attack]).to be_a(Integer)
        expect(attack_object[:damage]).to be_a(Integer)
      end
    end

    context 'defends' do
      attack_object = { name: 'test', target: opponent, attack: 10, damage: 2 }
      message = player.defend(attack_object)
      it 'returns a message' do
        expect(message).to be_a(String)
      end
    end
  end
end
