# frozen_string_literal: true

# Describes a maze that uses Dijkstras algorithm to find the shortest path
# between two vertices
class Maze
  def initialize(vertices)
    @vertices = vertices
    @min_distances = Hash.new(distance: Float::INFINITY)
    @vertices_to_visit = vertices.keys
  end

  def min_distance(origin, target)
    min_distances[origin] = {
      previous: nil,
      distance: 0
    }

    calculate_minimum_distances(origin)

    {
      steps: show_steps(origin, target),
      distance: min_distances[target][:distance]
    }
  end

  private

  attr_reader :vertices, :min_distances, :vertices_to_visit

  def calculate_minimum_distances(origin)
    current_vertex = origin
    vertices_to_visit.delete(current_vertex)

    until vertices_to_visit.empty?
      minimum_distances_from_vertex(current_vertex)
      current_vertex = closest_unvisited_vertex
      vertices_to_visit.delete(current_vertex)
    end
  end

  def minimum_distances_from_vertex(current_vertex)
    vertices[current_vertex].each do |vertex, distance|
      next unless min_distances[vertex][:distance] > distance

      min_distances[vertex] = {
        previous: current_vertex,
        distance: distance + min_distances[current_vertex][:distance]
      }
    end
  end

  def show_steps(origin, target)
    steps = []
    current_step = target

    while current_step != origin
      steps.prepend(current_step)
      current_step = min_distances[current_step][:previous]
    end

    steps.prepend(current_step)
  end

  def closest_unvisited_vertex
    min_distances
      .slice(*vertices_to_visit)
      .min_by { |_, vertex| vertex[:distance] }
      .to_a
      .first
  end
end
