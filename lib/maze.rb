# frozen_string_literal: true

# Describes a maze that uses Dijkstras algorithm to find the shortest path
# between two nodes
class Maze
  def initialize(vertices)
    @vertices = vertices
    @min_distances = {}
    @nodes_to_visit = vertices.keys
  end

  def min_distance(origin, target)
    min_distances[origin] = {
      previous: nil,
      distance: 0
    }

    current_node = origin
    until nodes_to_visit.empty?
      #  check the distance between the current node and the adjacent nodes
      #  visit the closest node
      vertices[current_node].each do |node, distance|
        next unless min_distances[node].nil? || min_distances[node][:distance] > distance

        min_distances[node] = {
          previous: current_node,
          distance: distance + min_distances[current_node][:distance]
        }
      end

      nodes_to_visit.delete(current_node)
      current_node = closest_unvisited_node
    end

    {
      steps: reverse_steps(origin, target),
      distance: min_distances[target][:distance]
    }
  end

  private

  attr_reader :vertices, :min_distances, :nodes_to_visit

  def reverse_steps(origin, target)
    steps = []
    current_step = target

    while current_step != origin
      steps.prepend(current_step)
      current_step = min_distances[current_step][:previous]
    end

    steps.prepend(current_step)
  end

  def closest_unvisited_node
    min_distances
      .slice(*nodes_to_visit)
      .min_by { |_, vertice| vertice[:distance] }
      .to_a
      .first
  end
end
