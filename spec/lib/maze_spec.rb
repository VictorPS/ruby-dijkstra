# frozen_string_literal: true
require_relative '../../lib/maze'

RSpec.describe Maze do
  # a - 1 - b
  # | \     |
  # 2  10   4
  # |     \ |
  # c       d
  subject(:maze) { Maze.new(edges) }
  let(:edges) do
    {
      a: { b: 1, c: 2, d: 10 },
      b: { a: 1, d: 4 },
      c: { a: 2 },
      d: { a: 10, b: 4 }
    }
  end

  describe '#min_distance' do
    it 'returns the steps and the minimum distance between the same vertices' do
      expect(maze.min_distance(:a, :a))
        .to eq({ steps: [:a], distance: 0 })
    end

    it 'returns the steps and the minimum distance between adjacent vertices' do
      expect(maze.min_distance(:a, :b))
        .to eq({ steps: %i[a b], distance: 1 })
    end

    it 'returns the steps and the minimum distance between further vertices' do
      expect(maze.min_distance(:a, :d))
        .to eq({ steps: %i[a b d], distance: 5 })
    end
  end
end
